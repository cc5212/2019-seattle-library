

-- 4 minutes, 36 seconds and 341 milliseconds
-- This script finds the filter and group checkout of books by 

register datafu-1.2.0.jar;
define Enumerate datafu.pig.bags.Enumerate('1');
raw_checkouts = LOAD 'hdfs://cm:9000/uhadoop2019/pablojose/checkout-group-by-month-only-books2/part-r-00000' USING PigStorage() AS (bibnum, year:int, month:int, count:int);

checkout_grp = GROUP raw_checkouts BY (year, month);
top10 = foreach checkout_grp {
        sorted = order raw_checkouts by count desc;
        top    = limit sorted 100;
        generate group, top;
};

top11 = foreach top10 generate FLATTEN(Enumerate(top)) as (bibnum, year, month, count, ranking);
top12 = ORDER top11 BY year, month, ranking ASC;

STORE top12 INTO '/uhadoop2019/pablojose/checkout-by-month-top-100-rank';