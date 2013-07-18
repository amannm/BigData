drop table if exists rxnorm.concepts;
create table rxnorm.concepts (
	rxcui character varying(8) not null,
	lat character varying(3) default 'ENG' not null,
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

drop table if exists rxnorm.relationships;
create table rxnorm.relationships (
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

drop table if exists rxnorm.attributes;
create table rxnorm.attributes (
	rxcui character varying(8),
	lui character varying(8),
	sui character varying(8),
	rxaui character varying(8),
	stype character varying(50),
	code character varying(50),
	atui character varying(11),
	satui character varying(50),
	atn character varying(1000) not null,
	sab character varying(20) not null,
	atv character varying(4000),
	suppress character varying (1),
	cvf character varying(50),
	tempcol text
);

drop table if exists rxnorm.docs;
create table rxnorm.docs (
	dockey	character varying(50) not null,
	value	character varying(1000),
	type	character varying(50) not null,
	expl	character varying(1000),
	tempcol text
);


copy rxnorm.concepts from 'C:/RxNorm/rrf/RXNCONSO.rrf' with (format csv, quote U&"\0005" , delimiter '|');
copy rxnorm.relationships from 'C:/RxNorm/rrf/RXNREL.rrf' with (delimiter '|');
copy rxnorm.attributes from 'C:/RxNorm/rrf/RXNSAT.rrf' with (delimiter '|');
copy rxnorm.docs from 'C:/RxNorm/rrf/RXNDOC.rrf' with (format csv, quote U&"\0005" , delimiter '|');

alter table rxnorm.concepts 
	drop tempcol,
	alter rxcui type integer using nullif(rxcui, '')::integer,
	alter rxaui type integer using nullif(rxaui, '')::integer,
	add primary key (rxaui);
alter table rxnorm.relationships
	drop tempcol,
	alter rxcui1 type integer using nullif(rxcui1, '')::integer,
	alter rxcui2 type integer using nullif(rxcui2, '')::integer,
	alter rxaui1 type integer using nullif(rxaui1, '')::integer,
	alter rxaui2 type integer using nullif(rxaui2, '')::integer;
alter table rxnorm.attributes 
	drop tempcol,
	alter rxcui type integer using nullif(rxcui, '')::integer,
	alter rxaui type integer using nullif(rxaui, '')::integer;
alter table rxnorm.docs 
	drop tempcol;


-- Below: Query returned successfully with no result in 517371 ms.
create index concepts_rxcui_index on rxnorm.concepts(rxcui);
create index concepts_str_index on rxnorm.concepts(str);
create index concepts_tty_index on rxnorm.concepts(tty);
create index concepts_code_index on rxnorm.concepts(code);
create index attributes_rxcui_index on rxnorm.attributes(rxcui);
create index attributes_atv_index on rxnorm.attributes(atv);
create index attributes_atn_index on rxnorm.attributes(atn);
create index relationships_rxcui1_index on rxnorm.relationships(rxcui1);
create index relationships_rxcui2_index on rxnorm.relationships(rxcui2);
create index relationships_rela_index on rxnorm.relationships(rela);

