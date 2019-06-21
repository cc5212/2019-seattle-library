-- This script finds the filter and group checkout of books by 



-- 3min
raw_checkouts = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/checkout-group-by-month-only-books2/part-r-00000' USING PigStorage() AS (bibnum, month, year, count:int);

-- 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-inventory-100k.csv'
group_checkouts = GROUP raw_checkouts by (year, month);
count_checkout = FOREACH group_checkouts GENERATE FLATTEN(group) as (year, month), SUM($1.count) as checkouts;
STORE count_checkout INTO '/uhadoop2019/pablojose/checkout-sum-by-month';
