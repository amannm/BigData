drop table if exists ibol.plants;
CREATE TABLE ibol.plants (
  processid character varying(255),
  sampleid character varying(255),
  museumid character varying(255),
  fieldid character varying(255),
  bin_guid character varying(255),
  bin_name character varying(255),
  vouchertype character varying(255),
  inst_reg character varying(255),
  phylum_reg character varying(255),
  class_reg character varying(255),
  order_reg character varying(255),
  family_reg character varying(255),
  subfamily_reg character varying(255),
  genus_reg character varying(255),
  species_reg character varying(255),
  taxonomist_reg character varying(255),
  collectors character varying(255),
  collectiondate character varying(255),
  lifestage character varying(255),
  lat double precision,
  lon double precision,
  site character varying(255),
  sector character varying(255),
  region character varying(255),
  province_reg character varying(255),
  country_reg character varying(255),
  fundingsrc character varying(255),
  seqentryid integer,
  seqdataid integer,
  marker_code character varying(255),
  nucraw text,
  aminoraw text,
  seq_update character varying(255),
  total_trace_count integer,
  high_trace_count integer,
  accession character varying(255)
);

copy ibol.plants
(processid,sampleid,museumid,fieldid,bin_guid,bin_name,vouchertype,inst_reg,phylum_reg,class_reg,order_reg,family_reg,subfamily_reg,genus_reg,species_reg,taxonomist_reg,collectors,collectiondate,lifestage,lat,lon,site,sector,region,province_reg,country_reg,fundingsrc,seqentryid,seqdataid,marker_code,nucraw,aminoraw,seq_update,
  -- 2.25 adds: total_trace_count,
  -- 3.75 adds: high_trace_count,
  accession
)
from 'C:/postgresdata/iBOL/iBOL_phase_2.0_plants.tsv'
with (format csv, delimiter '	', header);

copy ibol.plants
(processid,sampleid,museumid,fieldid,bin_guid,bin_name,vouchertype,inst_reg,phylum_reg,class_reg,order_reg,family_reg,subfamily_reg,genus_reg,species_reg,taxonomist_reg,collectors,collectiondate,lifestage,lat,lon,site,sector,region,province_reg,country_reg,fundingsrc,seqentryid,seqdataid,marker_code,nucraw,aminoraw,seq_update,
  total_trace_count,
  -- 3.75 adds: high_trace_count,
  accession
)
from 'C:/postgresdata/iBOL/iBOL_phase_2.25_plants.tsv'
with (format csv, delimiter '	', header);

copy ibol.plants
(processid,sampleid,museumid,fieldid,bin_guid,bin_name,vouchertype,inst_reg,phylum_reg,class_reg,order_reg,family_reg,subfamily_reg,genus_reg,species_reg,taxonomist_reg,collectors,collectiondate,lifestage,lat,lon,site,sector,region,province_reg,country_reg,fundingsrc,seqentryid,seqdataid,marker_code,nucraw,aminoraw,seq_update,
  total_trace_count,
  -- 3.75 adds: high_trace_count,
  accession
)
from 'C:/postgresdata/iBOL/iBOL_phase_2.50_plants.tsv'
with (format csv, delimiter '	', header);

copy ibol.plants
(processid,sampleid,museumid,fieldid,bin_guid,bin_name,vouchertype,inst_reg,phylum_reg,class_reg,order_reg,family_reg,subfamily_reg,genus_reg,species_reg,taxonomist_reg,collectors,collectiondate,lifestage,lat,lon,site,sector,region,province_reg,country_reg,fundingsrc,seqentryid,seqdataid,marker_code,nucraw,aminoraw,seq_update,
  total_trace_count,
  -- 3.75 adds: high_trace_count,
  accession
)
from 'C:/postgresdata/iBOL/iBOL_phase_2.75_plants.tsv'
with (format csv, delimiter '	', header);

copy ibol.plants
(processid,sampleid,museumid,fieldid,bin_guid,bin_name,vouchertype,inst_reg,phylum_reg,class_reg,order_reg,family_reg,subfamily_reg,genus_reg,species_reg,taxonomist_reg,collectors,collectiondate,lifestage,lat,lon,site,sector,region,province_reg,country_reg,fundingsrc,seqentryid,seqdataid,marker_code,nucraw,aminoraw,seq_update,
  total_trace_count,
  -- 3.75 adds: high_trace_count,
  accession
)
from 'C:/postgresdata/iBOL/iBOL_phase3.0_plants.tsv'
with (format csv, delimiter '	', header);

copy ibol.plants
(processid,sampleid,museumid,fieldid,bin_guid,bin_name,vouchertype,inst_reg,phylum_reg,class_reg,order_reg,family_reg,subfamily_reg,genus_reg,species_reg,taxonomist_reg,collectors,collectiondate,lifestage,lat,lon,site,sector,region,province_reg,country_reg,fundingsrc,seqentryid,seqdataid,marker_code,nucraw,aminoraw,seq_update,
  total_trace_count,
  -- 3.75 adds: high_trace_count,
  accession
)
from 'C:/postgresdata/iBOL/iBOL_phase3.25_plants.tsv'
with (format csv, delimiter '	', header);

copy ibol.plants
(processid,sampleid,museumid,fieldid,bin_guid,bin_name,vouchertype,inst_reg,phylum_reg,class_reg,order_reg,family_reg,subfamily_reg,genus_reg,species_reg,taxonomist_reg,collectors,collectiondate,lifestage,lat,lon,site,sector,region,province_reg,country_reg,fundingsrc,seqentryid,seqdataid,marker_code,nucraw,aminoraw,seq_update,
  total_trace_count,
  -- 3.75 adds: high_trace_count,
  accession
)
from 'C:/postgresdata/iBOL/iBOL_phase3.50_plants.tsv'
with (format csv, delimiter '	', header);

copy ibol.plants
(processid,sampleid,museumid,fieldid,bin_guid,bin_name,vouchertype,inst_reg,phylum_reg,class_reg,order_reg,family_reg,subfamily_reg,genus_reg,species_reg,taxonomist_reg,collectors,collectiondate,lifestage,lat,lon,site,sector,region,province_reg,country_reg,fundingsrc,seqentryid,seqdataid,marker_code,nucraw,aminoraw,seq_update,
  total_trace_count,
  high_trace_count,
  accession
)
from 'C:/postgresdata/iBOL/iBOL_phase_3.75_plants.tsv'
with (format csv, delimiter '	', header);