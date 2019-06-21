-- This script finds the filter and group checkout of books by 

check = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/checkout-group-by-month-only-books2/part-r-00000' USING PigStorage() AS (bibnum, month, year, count:int);
group_checkouts = GROUP check by (bibnum, year);
count_checkout = FOREACH group_checkouts GENERATE FLATTEN(group) as (bibnum, year), SUM($1.count) as checkouts;
count_check = ORDER count_checkout BY year, checkouts, bibnum ASC;

STORE count_check INTO '/uhadoop2019/pablojose/checkout-group-by-year-ob';
