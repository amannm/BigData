DROP TABLE IF EXISTS "ITIS".comments;
Create Table "ITIS".comments
 ( comment_id INTEGER NOT NULL,
   commentator VARCHAR(100),
   comment_detail text NOT NULL,
   comment_time_stamp timestamp without time zone NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (comment_id)
   );
DROP TABLE IF EXISTS "ITIS".geographic_div;
create table "ITIS".geographic_div 
 ( tsn INTEGER NOT NULL,
   geographic_value VARCHAR(45) NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (tsn,geographic_value)
   );

DROP TABLE IF EXISTS "ITIS".experts;
create table "ITIS".experts 
 ( expert_id_prefix CHAR(3) NOT NULL,
   expert_id INTEGER NOT NULL, 
   expert VARCHAR(100) NOT NULL,
   exp_comment VARCHAR(500), 
   update_date DATE NOT NULL,
   PRIMARY KEY (expert_id_prefix,expert_id)
   );

DROP TABLE IF EXISTS "ITIS".hierarchy;
CREATE TABLE "ITIS".hierarchy (
    hierarchy_string varchar(128) NOT NULL,
    TSN int NOT NULL,
    Parent_TSN int,
    level int NOT NULL,
    ChildrenCount int NOT NULL,
    PRIMARY KEY (hierarchy_string)
);
CREATE INDEX hierarchy_string on "ITIS".hierarchy (hierarchy_string);

DROP TABLE IF EXISTS "ITIS".jurisdiction;
create table "ITIS".jurisdiction 
 ( tsn INTEGER NOT NULL,
   jurisdiction_value VARCHAR(30) NOT NULL,
   origin VARCHAR(19) NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (tsn,jurisdiction_value)
);

DROP TABLE IF EXISTS "ITIS".kingdoms;
create table "ITIS".kingdoms 
 ( kingdom_id INTEGER NOT NULL,
   kingdom_name CHAR(10) NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (kingdom_id)
);

DROP TABLE IF EXISTS "ITIS".longnames;
create table "ITIS".longnames
 ( tsn INTEGER NOT NULL,
   completename VARCHAR(164) NOT NULL,
   PRIMARY KEY (tsn)
   );
   

DROP TABLE IF EXISTS "ITIS".nodc_ids;
create table "ITIS".nodc_ids 
 ( nodc_id CHAR(12) NOT NULL,
   update_date DATE NOT NULL,
   tsn INTEGER NOT NULL,
   PRIMARY KEY (nodc_id,tsn)
   );


DROP TABLE IF EXISTS "ITIS".other_sources;
create table "ITIS".other_sources
 ( 
 source_id_prefix CHAR(3) NOT NULL,
   source_id INTEGER NOT NULL,
   source_type CHAR(10) NOT NULL,
   source VARCHAR(64) NOT NULL,
   version CHAR(10) NOT NULL,
   acquisition_date DATE NOT NULL,
   source_comment VARCHAR(500),
   update_date DATE NOT NULL,
   PRIMARY KEY (source_id_prefix,source_id)
   );


DROP TABLE IF EXISTS "ITIS".publications;
create table "ITIS".publications
 ( pub_id_prefix CHAR(3) NOT NULL,
   publication_id INTEGER NOT NULL,
   reference_author VARCHAR(100) NOT NULL,
   title VARCHAR(255),
   publication_name VARCHAR(255) NOT NULL,
   listed_pub_date date,
   actual_pub_date DATE NOT NULL,
   publisher VARCHAR(80),
   pub_place VARCHAR(40),
   isbn VARCHAR(16),
   issn VARCHAR(16),
   pages VARCHAR(15),
   pub_comment VARCHAR(500),
   update_date DATE NOT NULL,
   PRIMARY KEY (pub_id_prefix,publication_id)
   );


DROP TABLE IF EXISTS "ITIS".strippedauthor;
create table "ITIS".strippedauthor
 ( 
 taxon_author_id INTEGER NOT NULL,
   shortauthor VARCHAR(100) NOT NULL,
   PRIMARY KEY (taxon_author_id)
   );


DROP TABLE IF EXISTS "ITIS".synonym_links;
create table "ITIS".synonym_links
 ( 
 tsn INTEGER NOT NULL,
   tsn_accepted INTEGER NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (tsn,tsn_accepted)
   );


DROP TABLE IF EXISTS "ITIS".taxon_authors_lkp;
Create Table "ITIS".taxon_authors_lkp 
 ( 
 taxon_author_id INTEGER NOT NULL,
   taxon_author VARCHAR(100) NOT NULL,
   update_date DATE NOT NULL,
   kingdom_id SMALLINT NOT NULL,
   short_author VARCHAR(100),
   PRIMARY KEY (taxon_author_id,kingdom_id)
   );


DROP TABLE IF EXISTS "ITIS".taxon_unit_types;
Create Table "ITIS".taxon_unit_types 
 ( 
 kingdom_id INTEGER NOT NULL,
   rank_id SMALLINT NOT NULL,
   rank_name CHAR(15) NOT NULL,
   dir_parent_rank_id SMALLINT NOT NULL,
   req_parent_rank_id SMALLINT NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (kingdom_id,rank_id)
   );


DROP TABLE IF EXISTS "ITIS".taxonomic_units;
Create Table "ITIS".taxonomic_units 
 ( 
 tsn INTEGER NOT NULL,
   unit_ind1 CHAR(1),
   unit_name1 CHAR(35) NOT NULL,
   unit_ind2 CHAR(1),
   unit_name2 VARCHAR(35),
   unit_ind3 VARCHAR(7),
   unit_name3 VARCHAR(35),
   unit_ind4 VARCHAR(7),
   unit_name4 VARCHAR(35),
   unnamed_taxon_ind CHAR(1),
   "usage" VARCHAR(12) NOT NULL,
   unaccept_reason VARCHAR(50),
   credibility_rtng VARCHAR(40) NOT NULL,
   completeness_rtng CHAR(10),
   currency_rating CHAR(7),
   phylo_sort_seq SMALLINT,
   initial_time_stamp timestamp without time zone NOT NULL,
   parent_tsn INTEGER,
   taxon_author_id INTEGER,
   hybrid_author_id INTEGER,
   kingdom_id SMALLINT NOT NULL,
   rank_id  SMALLINT NOT NULL,
   update_date DATE NOT NULL,
   uncertain_prnt_ind CHAR(3),
   name_usage VARCHAR(12),
   complete_name VARCHAR(300),
   PRIMARY KEY (tsn)
   );


DROP TABLE IF EXISTS "ITIS".tu_comments_links;
create table "ITIS".tu_comments_links
 ( 
 tsn INTEGER NOT NULL,
   comment_id INTEGER NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (tsn,comment_id)
   );

DROP TABLE IF EXISTS "ITIS".vernaculars;
create table "ITIS".vernaculars 
 ( 
tsn INTEGER NOT NULL,
   vernacular_name VARCHAR(80) NOT NULL,
   language VARCHAR(15) NOT NULL,
   approved_ind CHAR(1),
   update_date DATE NOT NULL,
   vern_id INTEGER NOT NULL,
   PRIMARY KEY (tsn,vern_id)
   );


DROP TABLE IF EXISTS "ITIS".vern_ref_links;
create table "ITIS".vern_ref_links
 ( 
 tsn INTEGER NOT NULL,
   doc_id_prefix CHAR(3) NOT NULL,
   documentation_id INTEGER NOT NULL,
   update_date DATE NOT NULL,
   vern_id INTEGER NOT NULL,
   PRIMARY KEY (tsn,doc_id_prefix,documentation_id,vern_id)
   );


DROP TABLE IF EXISTS "ITIS".reference_links;
create table "ITIS".reference_links
 ( 
 tsn INTEGER NOT NULL,
   doc_id_prefix CHAR(3) NOT NULL,
   documentation_id INTEGER NOT NULL,
   original_desc_ind CHAR(1),
   init_itis_desc_ind CHAR(1),
   change_track_id INTEGER,
   vernacular_name VARCHAR(80),
   update_date DATE NOT NULL,
   PRIMARY KEY (tsn,doc_id_prefix,documentation_id)
);


copy "ITIS"."comments" from 'C:\ITIS\itisMySQL032613\comments' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."experts" from 'C:\ITIS\itisMySQL032613\experts' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."geographic_div" from 'C:\ITIS\itisMySQL032613\geographic_div' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."jurisdiction" from 'C:\ITIS\itisMySQL032613\jurisdiction' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."kingdoms" from 'C:\ITIS\itisMySQL032613\kingdoms' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."longnames" from 'C:\ITIS\itisMySQL032613\longnames' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."nodc_ids" from 'C:\ITIS\itisMySQL032613\nodc_ids' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."other_sources" from 'C:\ITIS\itisMySQL032613\other_sources' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."publications" from 'C:\ITIS\itisMySQL032613\publications' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."strippedauthor" from 'C:\ITIS\itisMySQL032613\strippedauthor' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."synonym_links" from 'C:\ITIS\itisMySQL032613\synonym_links'  with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."taxon_authors_lkp" from 'C:\ITIS\itisMySQL032613\taxon_authors_lkp'  with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."taxon_unit_types" from 'C:\ITIS\itisMySQL032613\taxon_unit_types' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."taxonomic_units" from 'C:\ITIS\itisMySQL032613\taxonomic_units' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."tu_comments_links" from 'C:\ITIS\itisMySQL032613\tu_comments_links' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."vernaculars" from 'C:\ITIS\itisMySQL032613\vernaculars' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."hierarchy" from 'C:\ITIS\itisMySQL032613\hierarchy' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."reference_links" from 'C:\ITIS\itisMySQL032613\reference_links' with delimiter '|' encoding 'latin1' null '';
copy "ITIS"."vern_ref_links" from 'C:\ITIS\itisMySQL032613\vern_ref_links' with delimiter '|' encoding 'latin1' null '';


