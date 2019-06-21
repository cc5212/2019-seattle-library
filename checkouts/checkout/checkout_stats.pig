-- This script finds the filter and group checkout of books by 
-- 3min


-- only books

raw_checkouts_books = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/checkout-group-by-month-only-books2/part-r-00000' USING PigStorage() AS (bibnum, year:int, month:int, checkouts:int);
group_checkouts = GROUP raw_checkouts_books by (checkouts, month, year);
count_checkout = FOREACH group_checkouts GENERATE FLATTEN(group) as (checkouts, month, year), COUNT($1) as count_checkouts;
avg_group = GROUP count_checkout by (checkouts);
avg_checkout = FOREACH avg_group GENERATE FLATTEN(group) as (checkouts), SUM($1.count_checkouts)/152 as avg;
STORE avg_checkout INTO '/uhadoop2019/pablojose/stats/sum_check_div_total_months';


group_sum = GROUP raw_checkouts_books by (year, month);
sum_month = FOREACH group_sum GENERATE FLATTEN(group) as (year, month), SUM($1.count) as sum;
STORE sum_month INTO '/uhadoop2019/pablojose/stats/sum_month';


-- ALL

raw_checkouts_all = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/checkout-group-by-month/part-r-00000' USING PigStorage() AS (bibnum, year:int, month:int, checkouts:int);
group_checkouts_all = GROUP raw_checkouts_all by (checkouts, month, year);
count_checkout_all = FOREACH group_checkouts_all GENERATE FLATTEN(group) as (checkouts, month, year), COUNT($1) as count_checkouts;
avg_group_all = GROUP count_checkout_all by (checkouts);
avg_checkout_all = FOREACH avg_group_all GENERATE FLATTEN(group) as (checkouts), AVG($1.count_checkouts) as avg;
STORE avg_checkout_all INTO '/uhadoop2019/pablojose/stats/avg_checkout';

group_sum_all = GROUP raw_checkouts_all by (year, month);
sum_month_all = FOREACH group_sum_all GENERATE FLATTEN(group) as (year, month), SUM($1.count) as sum;
STORE sum_month_all INTO '/uhadoop2019/pablojose/stats/sum_month_all';
