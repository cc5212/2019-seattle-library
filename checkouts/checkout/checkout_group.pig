-- This script finds the filter and group checkout of books by 


-- 18 minutes, 14 seconds and 326 milliseconds (1094326 ms)
-- 2019-06-20 13:23:07,625 [main] INFO  org.apache.pig.Main - Pig script completed in 25 minutes, 11 seconds and 46 milliseconds (1511046 ms) (second version)
-- 38 mins


raw_checkouts = LOAD 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-checkouts.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (bibnum, barcode, itemtype, collection, callnumber, checkoutDateTime:chararray);
-- raw_checkouts = LOAD 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-checkouts-100k.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (bibnum, barcode, itemtype, collection, callnumber, checkoutDateTime:chararray);

rawDict = LOAD 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-ils-data-dictionary.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (code, description, codeType, formatGroup, formatSubgroup, categoryGroup, categorySubgroup);
-- 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-inventory-100k.csv'

dict = FOREACH rawDict GENERATE code, formatGroup, formatSubgroup;

-- 12/14/2005 05:56:00 PM
check1 = JOIN raw_checkouts BY itemtype, dict BY code; -- Join
check1_only_books = FILTER check1 BY (dict::formatSubgroup == 'Book'); -- Libros
check1_only_books_printed = FILTER check1_only_books BY (dict::formatGroup == 'Print'); -- Libros impresos

check = FOREACH check1_only_books GENERATE 
		raw_checkouts::bibnum as bibnum,
		raw_checkouts::barcode as barcode,
		-- raw_checkouts:barcode as barcode,
		GetMonth(ToDate(raw_checkouts::checkoutDateTime,'MM/dd/yyyy hh:mm:ss aa'))  AS month,
		GetYear(ToDate(raw_checkouts::checkoutDateTime,'MM/dd/yyyy hh:mm:ss aa'))  AS year;

group_checkouts = GROUP check by (bibnum, year, month);
count_checkout = FOREACH group_checkouts GENERATE FLATTEN(group) as (bibnum, year, month), COUNT($1) as checkouts;
count_check = ORDER count_checkout BY year, month, checkouts, bibnum ASC;
STORE count_check INTO '/uhadoop2019/pablojose/checkout-group-by-month-only-books2';