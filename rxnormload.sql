

-- COPY rxnorm.atomarchive FROM 'C:/RxNorm/rrf/RXNATOMARCHIVE.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.atomarchive DROP COLUMN tempcol;

-- COPY rxnorm.cui FROM 'C:/RxNorm/rrf/RXNCUI.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.cui DROP COLUMN tempcol;

-- COPY rxnorm.cuichanges FROM 'C:/RxNorm/rrf/RXNCUICHANGES.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.cuichanges DROP COLUMN tempcol;

-- -- requires manual editing: find line containing "(769" and add a '|' to ending
-- COPY rxnorm.doc FROM 'C:/RxNorm/rrf/RXNDOC.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.doc DROP COLUMN tempcol;
-- 
-- COPY rxnorm.sty FROM 'C:/RxNorm/rrf/RXNSTY.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.sty DROP COLUMN tempcol;
-- 
-- COPY rxnorm.sat FROM 'C:/RxNorm/rrf/RXNSAT.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.sat DROP COLUMN tempcol;

-- -- workaround for '' integers -> add null ''
-- COPY rxnorm.sab FROM 'C:/RxNorm/rrf/RXNSAB.rrf' with (DELIMITER '|', null '');
-- ALTER TABLE rxnorm.sab DROP COLUMN tempcol;
-- 

-- -- workaround for entry exceeding varchar(3000) for str -> change column to text
-- -- workaround for entry containing '\' -> format csv
-- -- workaround for entry containing '"' -> quote '~'
-- COPY rxnorm.conso FROM 'C:/RxNorm/rrf/RXNCONSO.rrf' with (format csv, quote '~', delimiter '|');
-- ALTER TABLE rxnorm.conso DROP COLUMN tempcol;

-- COPY rxnorm.rel FROM 'C:/RxNorm/rrf/RXNREL.rrf' with (delimiter '|');
-- ALTER TABLE rxnorm.rel DROP COLUMN tempcol;