inventory = LOAD 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-inventory.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (bibnum, title, author, isbn, publicationYear, publisher, subjects, itemtype, itemCollection, floatingItem, itemLocation, reportDate, itemCount);
checkouts_top10 = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/checkout-by-month-top-100-rank/part-r-00000' USING PigStorage() AS (bibnum, year, month, checkouts:int, ranking:int);

top10_per_month_joined = JOIN checkouts_top10 BY bibnum, inventory BY bibnum;

top10_per_month_joined_clean = FOREACH top10_per_month_joined GENERATE
								inventory::bibnum as bibnum,
								checkouts_top10::year as year,
								checkouts_top10::month as month,
								checkouts_top10::checkouts as checkouts,
								checkouts_top10::ranking as ranking,
								inventory::title as title,
								inventory::author as author,
								inventory::publicationYear as publicationYear,
								inventory::publisher as publisher,
								inventory::subjects as subjects,
								inventory::itemtype, 
								inventory::itemCollection;

final = FILTER top10_per_month_joined_clean BY (author is not NULL and author != ''); --


-- final = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/ranking-top10-books/part-r-00000' USING PigStorage() AS (bibnum, year, month, checkouts, title, author, publicationYear, publisher, subjects);

final_pre = FOREACH (GROUP final BY (bibnum, year, month)) {
 	result = LIMIT final 1;
  	GENERATE FLATTEN(result);
}

final_distinct = ORDER  final_pre BY year, month, ranking ASC;
-- final_distinct = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/slc/ranking-top100/part-r-00000' USING PigStorage() AS (bibnum, year, month, checkouts, ranking, title, author, publicationYear, publisher, subjects, itemtype);
popular_author_group = GROUP final_distinct BY author;
popular_author_sum = foreach popular_author_group GENERATE FLATTEN(group) as (author), SUM($1.checkouts) as checkouts;
pop_author =  ORDER popular_author_sum BY checkouts DESC;
pop_author = LIMIT  popular_author 100;

popular_publisher_group = GROUP final_distinct BY publisher;
popular_publisher_sum = foreach popular_publisher_group GENERATE FLATTEN(group) as (publisher), SUM($1.checkouts) as checkouts, COUNT($1);
popular_publisher =  ORDER popular_publisher_sum BY checkouts DESC;
pop_publisher = LIMIT  popular_publisher 100;

STORE pop_author INTO 'hdfs://cm:9000/uhadoop2019/pablojose/slc/pop-author2';
STORE pop_publisher INTO 'hdfs://cm:9000/uhadoop2019/pablojose/slc/pop-publisher';
STORE final_distinct INTO 'hdfs://cm:9000/uhadoop2019/pablojose/slc/ranking-top100';
