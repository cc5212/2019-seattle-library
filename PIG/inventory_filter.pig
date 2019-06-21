inventory = LOAD 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-inventory.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (bibnum, title, author, isbn, publicationYear, publisher, subjects, itemtype, itemCollection, floatingItem, itemLocation, reportDate, itemCount);
rawDict = LOAD 'hdfs://cm:9000/uhadoop/pablojose/slc/slc-ils-data-dictionary.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (code, description, codeType, formatGroup, formatSubgroup, categoryGroup, categorySubgroup);

dict = FOREACH rawDict GENERATE code, description, formatGroup, formatSubgroup;
inventoryDict = JOIN inventory BY itemtype, dict BY code; -- Join Inventario Dict


onlyBooks = FILTER inventoryDict BY (dict::formatSubgroup == 'Book'); -- Libros
onlyBooksPrinted = FILTER onlyBooks BY (dict::formatGroup == 'Print'); -- Libros impresos
onlyBooksPrintedFiltered = FILTER onlyBooksPrinted BY (inventory::author is not NULL and inventory::author != ''); --


books = FOREACH onlyBooksPrintedFiltered GENERATE
		inventory::bibnum as bibnum,
		inventory::title as title,
		inventory::author as author,
		inventory::isbn as isbn,
		inventory::publicationYear as publicationYear,
		inventory::publisher as publisher,
		inventory::subjects as subjects,
		inventory::itemtype as itemtype,
		inventory::itemCollection as itemCollection,
		-- floatingItem,
		inventory::itemLocation as itemLocation,
		dict::categoryGroup as categoryGroup,
		dict::description as description;


		-- reportDate,
		-- itemCount;,


STORE inventoryDict INTO 'hdfs://cm:9000/uhadoop2019/pablojose/inventory-only-books';
