

-- 4 minutes, 36 seconds and 341 milliseconds
-- This script finds the filter and group checkout of books by 
raw_checkouts = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/checkout-group-by-month-only-books2/part-r-00000' USING PigStorage() AS (bibnum, year:int, month:int, count:int);

checkout_grp = GROUP raw_checkouts BY (year, month);
top10 = foreach checkout_grp {
        sorted = order raw_checkouts by count desc;
        top    = limit sorted 10;
        generate group, flatten(top);
};

top11 = FOREACH top10 GENERATE top::bibnum as bibnum, FLATTEN(group) as (year, month), top::count as checkouts;
top12 = ORDER top11 BY year, month, checkouts ASC;

STORE top12 INTO '/uhadoop2019/pablojose/checkout-by-month-top-10-only-books2';