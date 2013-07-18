-- select *
-- from sr25."FOOD_DES" as srfd
-- 	inner join sr25."LANGUAL" as srla 
-- 		inner join langual.term as lte
-- 			inner join langual.taxonomy ltax
-- 				inner join itis.taxonomic_units on itisid = tsn
-- 			on lte.ftc = ltax.ftc
-- 		on srla."Factor" = lte.ftc
-- 	on srfd."NDB_No" = srla."NDB_No"
-- where ltax.class = 'FAM'

select *
from langual.term as lte
	left join langual.itis as ltax on lte.ftc = ltax.ftc
where substr(lte.ftc,1,1) = 'B' and ltax.ftc is null and lte.additional_info != '' 
and lte.additional_info ~ '^(<SCIFAM>)(.*)$' and lte.additional_info !~ '^(<SCIFAM>[ ]?)([A-Za-z]+)(ae)(.*)$'
order by lte.ftc

-- select *
-- from sr25."FOOD_DES" as srfd
-- 	left join sr25."LANGUAL" as srla on srfd."NDB_No" = srla."NDB_No"
-- where "Factor" is null

-- "PHY"
-- "SUBPHY"

-- "SUPCLASS"
-- "CLASS"
-- "INFCLASS"

-- "ORD"
-- "SUBORD"
-- "INFORD"

-- "SUPFAM"
-- "FAM"
-- "SUBFAM"

-- "TRI"
-- "TRIBE"

-- "GEN"

-- "NAM"
-- "SYN"
