drop table if exists "RxNorm".atomarchive;
create table "RxNorm".atomarchive
(
   RXAUI varchar(8) NOT NULL,
   AUI varchar(10),
   STR varchar(4000) NOT NULL,
   ARCHIVE_TIMESTAMP varchar(280) NOT NULL,
   CREATED_TIMESTAMP varchar(280) NOT NULL,
   UPDATED_TIMESTAMP varchar(280) NOT NULL,
   CODE varchar(50),
   IS_BRAND varchar(1),
   LAT varchar(3),
   LAST_RELEASED varchar(30),
   SAUI varchar(50),
   VSAB varchar(40),
   RXCUI varchar(8),
   SAB varchar(20),
   TTY varchar(20),
   MERGED_TO_RXCUI varchar(8)
)
;

drop table if exists "RxNorm".conso;
create table "RxNorm".conso
(
   RXCUI varchar(8) NOT NULL,
   LAT varchar (3) DEFAULT 'ENG' NOT NULL,
   TS varchar (1),
   LUI varchar(8),
   STT varchar (3),
   SUI varchar (8),
   ISPREF varchar (1),
   RXAUI  varchar(8) NOT NULL,
   SAUI varchar (50),
   SCUI varchar (50),
   SDUI varchar (50),
   SAB varchar (20) NOT NULL,
   TTY varchar (20) NOT NULL,
   CODE varchar (50) NOT NULL,
   STR varchar (3000) NOT NULL,
   SRL varchar (10),
   SUPPRESS varchar (1),
   CVF varchar(50)
)
;

drop table if exists "RxNorm".rel;
create table "RxNorm".rel
(
   RXCUI1    varchar(8) ,
   RXAUI1    varchar(8), 
   STYPE1    varchar(50),
   REL       varchar(4) ,
   RXCUI2    varchar(8) ,
   RXAUI2    varchar(8),
   STYPE2    varchar(50),
   RELA      varchar(100) ,
   RUI       varchar(10),
   SRUI      varchar(50),
   SAB       varchar(20) NOT NULL,
   SL        varchar(1000),
   DIR       varchar(1),
   RG        varchar(10),
   SUPPRESS  varchar(1),
   CVF       varchar(50)
)
;

drop table if exists "RxNorm".sab;
create table "RxNorm".sab
(
   VCUI varchar (8),
   RCUI varchar (8),
   VSAB varchar (20),
   RSAB varchar (20) NOT NULL,
   SON varchar (3000),
   SF varchar (20),
   SVER varchar (20),
   VSTART varchar (10),
   VEND varchar (10),
   IMETA varchar (10),
   RMETA varchar (10),
   SLC varchar (1000),
   SCC varchar (1000),
   SRL INTEGER,
   TFR INTEGER,
   CFR INTEGER,
   CXTY varchar (50),
   TTYL varchar (300),
   ATNL varchar (1000),
   LAT varchar (3),
   CENC varchar (20),
   CURVER varchar (1),
   SABIN varchar (1),
   SSN varchar (3000),
   SCIT varchar (4000)
   
)
;

drop table if exists "RxNorm".sat;
create table "RxNorm".sat
(
   RXCUI varchar(8),
   LUI varchar(8),
   SUI varchar(8),
   RXAUI varchar(8),
   STYPE varchar (50),
   CODE varchar (50),
   ATUI varchar(11),
   SATUI varchar (50),
   ATN varchar (1000) NOT NULL,
   SAB varchar (20) NOT NULL,
   ATV varchar (4000),
   SUPPRESS varchar (1),
   CVF varchar (50)
   
)
;

drop table if exists "RxNorm".sty;
create table "RxNorm".sty
(
   RXCUI varchar(8) NOT NULL,
   TUI varchar (4),
   STN varchar (100),
   STY varchar (50),
   ATUI varchar (11),
   CVF varchar (50)
   
)
;

drop table if exists "RxNorm".doc;
create table "RxNorm".doc (
    DOCKEY	varchar(50) NOT NULL,
    "VALUE"	varchar(1000),
    "TYPE"	varchar(50) NOT NULL,
    EXPL	varchar(1000)
)
;

drop table if exists "RxNorm".cuichanges;
create table "RxNorm".cuichanges
(
      RXAUI varchar(8),
      CODE varchar(50),
      SAB  varchar(20),
      TTY  varchar(20),
      STR  varchar(3000),
      OLD_RXCUI varchar(8) NOT NULL,
      NEW_RXCUI varchar(8) NOT NULL
)
;

drop table if exists "RxNorm".cui;
 create table "RxNorm".cui (
 cui1 varchar(8),
 ver_start varchar(20),
 ver_end   varchar(20),
 cardinality varchar(8),
 cui2        varchar(8)
)
;

copy "RxNorm".atomarchive from 'C:\RxNorm\rrf\RXNATOMARCHIVE.RRF' with (format csv delimiter '|' null '');
copy "RxNorm".conso from 'C:\RxNorm\rrf\RXNCONSO.RRF' with (format csv delimiter '|' null '');
copy "RxNorm".cui from 'C:\RxNorm\rrf\RXNCUI.RRF' with (format csv delimiter '|' null '');
copy "RxNorm".cuichanges from 'C:\RxNorm\rrf\RXNCUICHANGES.RRF' with (format csv delimiter '|' null '');
copy "RxNorm".doc from 'C:\RxNorm\rrf\RXNDOC.RRF' with (format csv delimiter '|' null '');
copy "RxNorm".rel from 'C:\RxNorm\rrf\RXNREL.RRF' with (format csv delimiter '|' null '');
copy "RxNorm".sab from 'C:\RxNorm\rrf\RXNSAB.RRF' with (format csv delimiter '|' null '');
copy "RxNorm".sat from 'C:\RxNorm\rrf\RXNSAT.RRF' with (format csv delimiter '|' null '');
copy "RxNorm".sty from 'C:\RxNorm\rrf\RXNSTY.RRF' with (format csv delimiter '|' null '');
 
