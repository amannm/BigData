drop table if exists rxnorm.attributes;
create table rxnorm.attributes (
   RXCUI VARCHAR(8),
   LUI VARCHAR(8),
   SUI VARCHAR(8),
   RXAUI VARCHAR(8),
   STYPE VARCHAR (50),
   CODE VARCHAR (50),
   ATUI VARCHAR(11),
   SATUI VARCHAR (50),
   ATN VARCHAR (1000) NOT NULL,
   SAB VARCHAR (20) NOT NULL,
   ATV VARCHAR (4000),
   SUPPRESS VARCHAR (1),
   CVF VARCHAR (50),
   tempcol text
);
copy rxnorm.attributes from 'C:/RxNorm/rrf/RXNSAT.rrf' with (delimiter '|');
alter table rxnorm.attributes drop tempcol;