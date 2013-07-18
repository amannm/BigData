-- load data into temporary tables

create temporary table tempconcepts (
   rxcui character varying(8) not null,
   lat character varying(3) default 'eng' not null,
   ts character varying(1),
   lui character varying(8),
   stt character varying(3),
   sui character varying(8),
   ispref character varying(1),
   rxaui  character varying(8) not null,
   saui character varying(50),
   scui character varying(50),
   sdui character varying(50),
   sab character varying(20) not null,
   tty character varying(20) not null,
   code character varying(50) not null,
   str character varying(3000) not null,
   srl character varying(10),
   suppress character varying(1),
   cvf character varying(50),
   tempcol text
);

create temporary table temprelationships (
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

create temporary table tempattributes (
   rxcui varchar(8),
   lui varchar(8),
   sui varchar(8),
   rxaui varchar(8),
   stype varchar(50),
   code varchar(50),
   atui varchar(11),
   satui varchar(50),
   atn varchar(1000) not null,
   sab varchar(20) not null,
   atv varchar(4000),
   suppress varchar(1),
   cvf varchar(50),
   dummy text
);

copy tempconcepts from 'C:/RxNorm/rrf/RXNCONSO.rrf' with (format csv, quote U&"\0005" , delimiter '|');
copy temprelationships from 'C:/RxNorm/rrf/RXNREL.rrf' with (delimiter '|');
copy tempattributes from 'C:/RxNorm/rrf/RXNSAT.rrf' with (delimiter '|');


-- slice data according to source
-- GS
-- MDDB
-- MMSL
-- MMX
-- MSH
-- MTHFDA
-- MTHSPL
-- NDDF
-- NDFRT
-- SNOMEDCT 
-- VANDF
do $$
	declare 
		rowitem record;
		foo varchar(30);
	begin
		for rowitem in (select distinct sab from tempconcepts order by sab) loop
			foo := rowitem.sab;
		     execute 'drop schema if exists ' || lower(foo) || ' cascade';
		     execute 'create schema ' || lower(foo);
		     execute 'create table ' || lower(foo) || '.concepts as select * from tempconcepts where sab = ''' || foo || '''';
		     execute 'create table ' || lower(foo) || '.relationships as select * from temprelationships where sab = ''' || foo || '''';
		     execute 'create table ' || lower(foo) || '.attributes as select * from tempattributes where sab = ''' || foo || '''';
		end loop;
	end;
$$;
