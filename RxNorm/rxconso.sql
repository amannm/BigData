drop table if exists rxnorm.concepts;
create table rxnorm.concepts (
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
copy rxnorm.concepts from 'C:/RxNorm/rrf/RXNCONSO.rrf' with (format csv, quote U&"\0005" , delimiter '|');
alter table rxnorm.concepts drop tempcol;