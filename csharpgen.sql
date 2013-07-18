copy (
with 
totals as (
	select tty, count(rxcui)::numeric as numObjects
	from rxnorm.concepts
	group by tty
),
source1 as (
	select c1.rxcui as sid, c1.tty as st, rela as p, count(c2.rxcui) as oMult, c2.tty as ot
	from rxnorm.concepts as c1
		left join rxnorm.relationships 
			left join rxnorm.concepts as c2 on rxcui1 = c2.rxcui
		on c1.rxcui = rxcui2
		left join rxnorm.attributes as c2 on c2.rxcui = rxcui1
		inner join rxnorm.attributes as a on a.rxcui = rxcui2
	group by rxcui2, c1.tty, rela, c2.tty
),
source3 as (
	select st, replace(initcap(p),'_','') as p, ot, coalesce(replace(initcap(fullname),' ',''), 'object') as classname, count(sid) as numObjectsWithProp, max(oMult) as maxMult
	from source1 left join amann.termtypeabbreviations on ot = tty
	group by st, p, ot, fullname
),
source4 as (
	select st,
	string_agg('[DataMember] public ' ||
		case when maxMult > 1 
			then 'List<' || classname || '> ' || p || ot
			else classname || case when numObjectsWithProp/numObjects = 1.0 then '' else '?' end || ' ' || p || ot
		end || ' { get; set; }', ' ') as fields
	from source3
		inner join totals on st = tty
	group by st
),
almost as (
	select '[DataContract] public class ' || replace(initcap(fullname),' ','') || '{ ' || string_agg(fields, ' ') || ' }' as res
	from source4 inner join amann.termtypeabbreviations on st = tty
	group by fullname
)
select 'using System.Collections.Generic; using System.Runtime.Serialization; namespace Data { ' || string_agg(res, ' ') || ' }'
from almost 
)
to 'c:/postgresdata/stuff.cs'