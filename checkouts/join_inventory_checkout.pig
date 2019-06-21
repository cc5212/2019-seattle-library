inventory = LOAD 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-inventory.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (bibnum, title, author, isbn, publicationYear, publisher, subjects, itemtype, itemCollection, floatingItem, itemLocation, reportDate, itemCount);
checkouts_month = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/checkout-group-by-month-only-books2/part-r-00000' USING PigStorage() AS (bibnum, month, year, count:int);

checkout_grp = GROUP checkouts_month BY (year, month);
top = foreach checkout_grp {
        sorted = order checkouts_month by count desc;
        top    = limit sorted 10;
        generate group, flatten(top);
};

top10_per_month = FOREACH top GENERATE FLATTEN(group) as (year, month), top::bibnum as bibnum, top::count as ncheckouts;
inventory_books = FILTER inventory BY (author is not NULL and author != ''); --
top10_per_month_joined = JOIN top10_per_month BY bibnum, inventory_books BY bibnum;
top10_per_month_joined_clean = FOREACH top10_per_month_joined GENERATE
								top10_per_month::year as year,
								top10_per_month::month as month,
								top10_per_month::ncheckouts as checkouts,d
								inventory_books::bibnum as bibnum,
								inventory_books::title as title,
								inventory_books::author as author,
								inventory_books::publicationYear as publicationYear,
								inventory_books::publisher as publisher,
								inventory_books::subjects as subjects;

STORE top10_per_month_joined_clean INTO 'hdfs://cm:9000/uhadoop2019/pablojose/ranking-top10-per-month';
