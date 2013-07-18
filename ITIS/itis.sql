drop table if exists itis.comments;
Create Table itis.comments
 ( comment_id INTEGER NOT NULL,
   commentator VARCHAR(100),
   comment_detail text NOT NULL,
   comment_time_stamp timestamp without time zone NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (comment_id)
   );
drop table if exists itis.geographic_div;
create table itis.geographic_div 
 ( tsn INTEGER NOT NULL,
   geographic_value VARCHAR(45) NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (tsn,geographic_value)
   );

drop table if exists itis.experts;
create table itis.experts 
 ( expert_id_prefix CHAR(3) NOT NULL,
   expert_id INTEGER NOT NULL, 
   expert VARCHAR(100) NOT NULL,
   exp_comment VARCHAR(500), 
   update_date DATE NOT NULL,
   PRIMARY KEY (expert_id_prefix,expert_id)
   );

drop table if exists itis.hierarchy;
CREATE TABLE itis.hierarchy (
    hierarchy_string varchar(128) NOT NULL,
    TSN int NOT NULL,
    Parent_TSN int,
    level int NOT NULL,
    ChildrenCount int NOT NULL,
    PRIMARY KEY (hierarchy_string)
);
CREATE INDEX hierarchy_string on itis.hierarchy (hierarchy_string);

drop table if exists itis.jurisdiction;
create table itis.jurisdiction 
 ( tsn INTEGER NOT NULL,
   jurisdiction_value VARCHAR(30) NOT NULL,
   origin VARCHAR(19) NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (tsn,jurisdiction_value)
);

drop table if exists itis.kingdoms;
create table itis.kingdoms 
 ( kingdom_id INTEGER NOT NULL,
   kingdom_name CHAR(10) NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (kingdom_id)
);

drop table if exists itis.longnames;
create table itis.longnames
 ( tsn INTEGER NOT NULL,
   completename VARCHAR(164) NOT NULL,
   PRIMARY KEY (tsn)
   );
   

drop table if exists itis.nodc_ids;
create table itis.nodc_ids 
 ( nodc_id CHAR(12) NOT NULL,
   update_date DATE NOT NULL,
   tsn INTEGER NOT NULL,
   PRIMARY KEY (nodc_id,tsn)
   );


drop table if exists itis.other_sources;
create table itis.other_sources
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


drop table if exists itis.publications;
create table itis.publications
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


drop table if exists itis.strippedauthor;
create table itis.strippedauthor
 ( 
 taxon_author_id INTEGER NOT NULL,
   shortauthor VARCHAR(100) NOT NULL,
   PRIMARY KEY (taxon_author_id)
   );


drop table if exists itis.synonym_links;
create table itis.synonym_links
 ( 
 tsn INTEGER NOT NULL,
   tsn_accepted INTEGER NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (tsn,tsn_accepted)
   );


drop table if exists itis.taxon_authors_lkp;
Create Table itis.taxon_authors_lkp 
 ( 
 taxon_author_id INTEGER NOT NULL,
   taxon_author VARCHAR(100) NOT NULL,
   update_date DATE NOT NULL,
   kingdom_id SMALLINT NOT NULL,
   short_author VARCHAR(100),
   PRIMARY KEY (taxon_author_id,kingdom_id)
   );


drop table if exists itis.taxon_unit_types;
Create Table itis.taxon_unit_types 
 ( 
 kingdom_id INTEGER NOT NULL,
   rank_id SMALLINT NOT NULL,
   rank_name CHAR(15) NOT NULL,
   dir_parent_rank_id SMALLINT NOT NULL,
   req_parent_rank_id SMALLINT NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (kingdom_id,rank_id)
   );


drop table if exists itis.taxonomic_units;
Create Table itis.taxonomic_units 
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
   name_usage VARCHAR(12) NOT NULL,
   complete_name VARCHAR(300),
   PRIMARY KEY (tsn)
   );


drop table if exists itis.tu_comments_links;
create table itis.tu_comments_links
 ( 
 tsn INTEGER NOT NULL,
   comment_id INTEGER NOT NULL,
   update_date DATE NOT NULL,
   PRIMARY KEY (tsn,comment_id)
   );

drop table if exists itis.vernaculars;
create table itis.vernaculars 
 ( 
tsn INTEGER NOT NULL,
   vernacular_name VARCHAR(80) NOT NULL,
   language VARCHAR(15) NOT NULL,
   approved_ind CHAR(1),
   update_date DATE NOT NULL,
   vern_id INTEGER NOT NULL,
   PRIMARY KEY (tsn,vern_id)
   );


drop table if exists itis.vern_ref_links;
create table itis.vern_ref_links
 ( 
 tsn INTEGER NOT NULL,
   doc_id_prefix CHAR(3) NOT NULL,
   documentation_id INTEGER NOT NULL,
   update_date DATE NOT NULL,
   vern_id INTEGER NOT NULL,
   PRIMARY KEY (tsn,doc_id_prefix,documentation_id,vern_id)
   );


drop table if exists itis.reference_links;
create table itis.reference_links
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


copy itis."comments" from 'C:\ITIS\itisMySQL032613\comments' with delimiter '|' encoding 'latin1' null '';
copy itis."experts" from 'C:\ITIS\itisMySQL032613\experts' with delimiter '|' encoding 'latin1' null '';
copy itis."geographic_div" from 'C:\ITIS\itisMySQL032613\geographic_div' with delimiter '|' encoding 'latin1' null '';
copy itis."jurisdiction" from 'C:\ITIS\itisMySQL032613\jurisdiction' with delimiter '|' encoding 'latin1' null '';
copy itis."kingdoms" from 'C:\ITIS\itisMySQL032613\kingdoms' with delimiter '|' encoding 'latin1' null '';
copy itis."longnames" from 'C:\ITIS\itisMySQL032613\longnames' with delimiter '|' encoding 'latin1' null '';
copy itis."nodc_ids" from 'C:\ITIS\itisMySQL032613\nodc_ids' with delimiter '|' encoding 'latin1' null '';
copy itis."other_sources" from 'C:\ITIS\itisMySQL032613\other_sources' with delimiter '|' encoding 'latin1' null '';
copy itis."publications" from 'C:\ITIS\itisMySQL032613\publications' with delimiter '|' encoding 'latin1' null '';
copy itis."strippedauthor" from 'C:\ITIS\itisMySQL032613\strippedauthor' with delimiter '|' encoding 'latin1' null '';
copy itis."synonym_links" from 'C:\ITIS\itisMySQL032613\synonym_links'  with delimiter '|' encoding 'latin1' null '';
copy itis."taxon_authors_lkp" from 'C:\ITIS\itisMySQL032613\taxon_authors_lkp'  with delimiter '|' encoding 'latin1' null '';
copy itis."taxon_unit_types" from 'C:\ITIS\itisMySQL032613\taxon_unit_types' with delimiter '|' encoding 'latin1' null '';
copy itis."taxonomic_units" from 'C:\ITIS\itisMySQL032613\taxonomic_units' with delimiter '|' encoding 'latin1' null '';
copy itis."tu_comments_links" from 'C:\ITIS\itisMySQL032613\tu_comments_links' with delimiter '|' encoding 'latin1' null '';
copy itis."vernaculars" from 'C:\ITIS\itisMySQL032613\vernaculars' with delimiter '|' encoding 'latin1' null '';
copy itis."hierarchy" from 'C:\ITIS\itisMySQL032613\hierarchy' with delimiter '|' encoding 'latin1' null '';
copy itis."reference_links" from 'C:\ITIS\itisMySQL032613\reference_links' with delimiter '|' encoding 'latin1' null '';
copy itis."vern_ref_links" from 'C:\ITIS\itisMySQL032613\vern_ref_links' with delimiter '|' encoding 'latin1' null '';

