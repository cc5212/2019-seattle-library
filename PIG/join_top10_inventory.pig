inventory = LOAD 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-inventory.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (bibnum, title, author, isbn, publicationYear, publisher, subjects, itemtype, itemCollection, floatingItem, itemLocation, reportDate, itemCount);
checkouts_top10 = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/checkout-by-month-top-10-only-books2' USING PigStorage() AS (bibnum, year, month, checkouts:int);

top10_per_month_joined = JOIN checkouts_top10 BY bibnum, inventory BY bibnum;

top10_per_month_joined_clean = FOREACH top10_per_month_joined GENERATE
								inventory::bibnum as bibnum,
								checkouts_top10::year as year,
								checkouts_top10::month as month,
								checkouts_top10::checkouts as checkouts,
								inventory::title as title,
								inventory::author as author,
								inventory::publicationYear as publicationYear,
								inventory::publisher as publisher,
								inventory::subjects as subjects,
								inventory::itemtype, 
								inventory::itemCollection;

final = FILTER top10_per_month_joined_clean BY (author is not NULL and author != ''); --

-- final = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/ranking-top10-books/part-r-00000' USING PigStorage() AS (bibnum, year, month, checkouts, title, author, publicationYear, publisher, subjects);


final_distinct = FOREACH (GROUP final BY (bibnum, year, month)) {
 	result = LIMIT final 1;
  	GENERATE FLATTEN(result);
}

STORE final_distinct INTO 'hdfs://cm:9000/uhadoop2019/pablojose/slc/ranking-top10-books';
