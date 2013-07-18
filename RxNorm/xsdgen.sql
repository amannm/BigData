copy (
with 
totals as (
select tty, count(rxcui)::numeric as numObjects
from rxnorm.concepts
group by tty
),
source1 as (
	select c1.rxcui as sid, c1.tty as st, rela as p, c2.rxcui as oid, c2.tty as ot
	from rxnorm.relationships
		inner join rxnorm.concepts as c1 on c1.rxcui = rxcui2
		inner join rxnorm.concepts as c2 on c2.rxcui = rxcui1
),
otgroup as (
	select sid, st, p, ot, count(oid) as oMult
	from source1
	group by st, p, ot, sid
),
source3 as (
	select st, p, ot, coalesce(fullname, 'unknown') as fulltypename, count(sid) as numObjectsWithProp, max(oMult) as maxMult
	from otgroup left join amann.termtypeabbreviations on ot = tty
	group by st, p, ot, fullname
),
source4 as (
	select st,
		xmlelement(name "xs:element",
			xmlattributes( 
				replace(p, '_', '-') as "name"
			),
			xmlelement(name "xs:complexType",
				xmlelement(name "xs:sequence",
					xmlagg(
						xmlelement(name "xs:element",
							xmlattributes(
							replace(fulltypename,' ','-') || '-link' as "name", 
							'association' as "type", 
							case when numObjectsWithProp/numObjects = 1.0 then '1' else '0' end as "minOccurs", 
							case when maxMult > 1 then 'unbounded' else '1' end as "maxOccurs"
							)	
						)
					)
				)
			)
		) as propertyXML
	from source3 inner join totals on st = tty
	group by st, p
),
almost as (
select 
xmlelement(name "xs:element",
	xmlattributes(replace(fullname,' ','-') as "name", replace(fullname,' ','-') as "type", '0' as "minOccurs")
) as gele,
xmlelement(name "xs:complexType",
	xmlattributes(replace(fullname,' ','-') as "name"),
	xmlelement(name "xs:sequence", xmlagg(propertyXML))
) as ctypes
from source4
	inner join amann.termtypeabbreviations on st = tty
group by fullname
)
select 
	xmlroot(
		xmlelement(name "xs:schema", 
			xmlattributes('qualified' as "elementFormDefault", 'http://www.w3.org/2001/XMLSchema' as "xmlns:xs"), 
			xmlelement(name "xs:complexType", 
				xmlattributes('association' as "name"),
				xmlelement(name "xs:sequence",
					xmlelement(name "xs:element", xmlattributes('id' as "name", 'xs:int' as "type")),
					xmlelement(name "xs:element", xmlattributes('name' as "name", 'xs:string' as "type"))
				)
			), 
			xmlagg(ctypes), 
			xmlelement(name "xs:element", 
				xmlattributes('data' as "name"),
				xmlelement(name "xs:complexType", 
					xmlelement(name "xs:sequence", xmlagg(gele))
				)
			)
		), 
		version '1.0'
	)
from almost
)
to 'c:/postgresdata/stuff.xsd'