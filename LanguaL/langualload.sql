drop schema if exists langual cascade;
create schema langual;
create table langual.terms (
  ftc character varying(255),
  term character varying(255),
  bt character varying(255),
  sn text,
  ai text,
  synonyms text,
  relatedterms character varying(255),
  classification boolean,
  active boolean,
  dateupdate character varying(255),
  datecreated character varying(255),
  updatecomment character varying(255),
  single boolean
);
copy langual.terms from 'c:/postgresdata/LanguaL.csv';

-- create table langual.relations as select ftc, unnest(string_to_array(relatedterms, '|'))::character varying(255) as relatedterm from langual.terms where relatedterms != '';
-- create table langual.synonyms as select ftc, unnest(string_to_array(synonyms, '|'))::character varying(255) as synonym, false as primary from langual.terms where synonyms != '';

-- alter table langual.terms
-- 	drop term,
-- 	drop relatedterms,
-- 	drop synonyms;
delete from langual.terms where active = false;


create table langual.relations as select ftc, unnest(string_to_array(relatedterms, '|'))::character varying(255) as related from langual.terms where relatedterms != '';
create table langual.synonyms as select ftc, unnest(string_to_array(synonyms, '|'))::character varying(255) as synonym from langual.terms where synonyms != '';
create table langual.hierarchy as select ftc as narrower, bt as broader from langual.terms where bt != '';

create table langual.term as select ftc, term, sn as usage, ai as additional_info from langual.terms;
create table langual.itis as (with asdf as (select ftc, regexp_matches(additional_info, '(ITIS[ |>])([0-9]+)', 'g') as tax from langual.term) select distinct ftc, tax[2]::integer as tsn from asdf);


-- create table langual.term as select ftc, lower(term), bt, sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single from langual.terms;


--from langual.terms where substr(ftc,1,1) = 'A';
--delete from langual.terms where substr(ftc,1,1) = 'A';
-- 
-- create table langual.foodsource as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'B';
-- delete from langual.terms where substr(ftc,1,1) = 'B';
-- 
-- create table langual.organismparts as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'C';
-- delete from langual.terms where substr(ftc,1,1) = 'C';
-- 
-- -- E F G H
-- 
-- create table langual.physchars as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'E';
-- delete from langual.terms where substr(ftc,1,1) = 'E';
-- 
-- create table langual.heattreatextent as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'F';
-- delete from langual.terms where substr(ftc,1,1) = 'F';
-- 
-- create table langual.cookingmethod as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'G';
-- delete from langual.terms where substr(ftc,1,1) = 'G';
-- 
-- create table langual.treatment as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'H';
-- delete from langual.terms where substr(ftc,1,1) = 'H';
-- 
-- -- J K
-- 
-- create table langual.preservation as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'J';
-- delete from langual.terms where substr(ftc,1,1) = 'J';
-- 
-- create table langual.packing as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'K';
-- delete from langual.terms where substr(ftc,1,1) = 'K';
-- 
-- 
-- -- M N
-- 
-- create table langual.containerorwrapping as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'M';
-- delete from langual.terms where substr(ftc,1,1) = 'M';
-- 
-- create table langual.foodcontactsurface as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'N';
-- delete from langual.terms where substr(ftc,1,1) = 'N';
-- 
-- -- P R
-- 
-- create table langual.claims as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'P';
-- delete from langual.terms where substr(ftc,1,1) = 'P';
-- 
-- create table langual.geography as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'R';
-- delete from langual.terms where substr(ftc,1,1) = 'R';
-- 
-- -- Z
-- create table langual.foodcharacteristics as
-- select substr(ftc,2)::integer as id, lower(term), substr(bt,2), sn, ai, synonyms, relatedterms, classification, active, dateupdate, datecreated, updatecomment, single 
-- from langual.terms where substr(ftc,1,1) = 'Z';
-- delete from langual.terms where substr(ftc,1,1) = 'Z';
-- 
