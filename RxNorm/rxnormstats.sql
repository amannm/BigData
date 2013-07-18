with

orc as (
	select rxcui2 as predecessorObject, rela as propertyName, tty as successorClass, count(rxcui) as totalSuccessorObjects
	from rxnorm.relationships as r inner join rxnorm.concepts as c on rxcui1 = rxcui
	where r.sab = 'RXNORM' and c.sab = 'RXNORM' and rel != 'SY' and tty != 'SY' and tty != 'TMSY'
	group by 1,2,3
),
crc as (
	select tty as predecessorClass,  property, successorClass, min(totalSuccessorObjects), avg(totalSuccessorObjects), max(totalSuccessorObjects) as maxSuccessorObjects, stddev_pop(totalSuccessorObjects), count(rxcui)
	from rxnorm.concepts inner join orc on rxcui = predecessorObject
	where sab = 'RXNORM' and tty != 'SY' and tty != 'TMSY'
	group by 1,2,3
),
crxc as (
	select tty as predecessorClass,  property, count(successorClass) as numOverloads
	from crc
	group by 1,2
),
co as (
	select tty as className, count(rxcui) as numMembers
	from rxnorm.concepts
	where sab = 'RXNORM' and tty != 'SY' and tty != 'TMSY'
	group by 1
)
select className, 
	string_agg(
		case when maxSuccessorObjects > 1
		then 'drop table if exists rxnorm.' || predecessorClass || '_' || property || "_" || successorClass || '; '
		||
		|| 'create table rxnorm.' || predecessorClass || '_' || property || "_" || successorClass || '(left integer, right integer);'
		else ''
		end
	),
	string_agg(
		property || 
		case when numOverloads > 1
		then '_' || successorClass
		else ''
		end
		case when maxSuccessorObjects > 1
		then '_' || successorClass
		else ''
		end
		
	) 
from crc 
natural join co
natural join crxc
group by className