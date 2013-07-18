drop table if exists rxnorm.relationships;
create table rxnorm.relationships
(
  rxcui1 character varying(8),
  rxaui1 character varying(8),
  stype1 character varying(50),
  rel character varying(4),
  rxcui2 character varying(8),
  rxaui2 character varying(8),
  stype2 character varying(50),
  rela character varying(100),
  rui character varying(10),
  srui character varying(50),
  sab character varying(20) not null,
  sl character varying(1000),
  dir character varying(1),
  rg character varying(10),
  suppress character varying(1),
  cvf character varying(50),
  tempcol text
);
copy rxnorm.relationships from 'C:/RxNorm/rrf/RXNREL.rrf' with (delimiter '|');
alter table rxnorm.relationships drop column tempcol;

-- COPY rxnorm.atomarchive FROM 'C:/RxNorm/rrf/RXNATOMARCHIVE.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.atomarchive DROP COLUMN tempcol;
-- 
-- COPY rxnorm.cui FROM 'C:/RxNorm/rrf/RXNCUI.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.cui DROP COLUMN tempcol;
-- 
-- COPY rxnorm.cuichanges FROM 'C:/RxNorm/rrf/RXNCUICHANGES.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.cuichanges DROP COLUMN tempcol;
-- 
-- COPY rxnorm.doc FROM 'C:/RxNorm/rrf/RXNDOC.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.doc DROP COLUMN tempcol;
-- 
-- COPY rxnorm.sty FROM 'C:/RxNorm/rrf/RXNSTY.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.sty DROP COLUMN tempcol;
-- 
-- COPY rxnorm.sat FROM 'C:/RxNorm/rrf/RXNSAT.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.sat DROP COLUMN tempcol;
-- 
-- COPY rxnorm.sab FROM 'C:/RxNorm/rrf/RXNSAB.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.sab DROP COLUMN tempcol;
-- 
-- COPY rxnorm.conso FROM 'C:/RxNorm/rrf/RXNCONSO.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.conso DROP COLUMN tempcol;
-- 
-- COPY rxnorm.rel FROM 'C:/RxNorm/rrf/RXNREL.rrf' DELIMITER '|';
-- ALTER TABLE rxnorm.rel DROP COLUMN tempcol;