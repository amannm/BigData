-- alter table rxnorm.concepts 
-- 	alter rxcui type integer using (rxcui::integer),
-- 	alter rxaui type integer using (rxaui::integer)
-- delete from rxnorm.relationships 
-- where rxcui1 = '';
-- alter table rxnorm.relationships 
-- 	alter rxcui1 type integer using (rxcui1::integer),
-- 	alter rxcui2 type integer using (rxcui2::integer)
-- ALTER TABLE rxnorm.concepts
--   ADD PRIMARY KEY (rxaui);
-- ALTER TABLE rxnorm.relationships
--   ADD PRIMARY KEY (rxcui1, rela, rxcui2);
-- CREATE INDEX 
--    ON mthspl.concepts (rxcui ASC NULLS LAST);
-- 
-- CREATE INDEX 
--    ON mthspl.relationships (rxcui1 ASC NULLS LAST);
-- 
-- CREATE INDEX 
--    ON mthspl.relationships (rxcui2 ASC NULLS LAST);
-- CREATE INDEX 
--    ON mthspl.attributes (rxcui ASC NULLS LAST);
-- 
-- CREATE INDEX 
--    ON mthspl.attributes (rxcui ASC NULLS LAST);
-- 
CREATE INDEX 
   ON mthspl.attributes (atn ASC NULLS LAST);
   
-- CREATE INDEX 
--    ON mthspl.relationships (rela ASC NULLS LAST);

-- alter table mthspl.attributes
-- 	alter rxcui type integer using (coalesce(rxcui, '0')::integer);
-- alter table mthspl.concepts
-- 	alter rxcui type integer using (coalesce(rxcui, '0')::integer);
-- alter table mthspl.relationships
-- 	alter rxcui1 type integer using (coalesce(nullif(rxcui1, ''), '0')::integer),
-- 	alter rxcui2 type integer using (coalesce(nullif(rxcui2, ''), '0')::integer)