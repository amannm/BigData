copy (
with 
typeTotals as (
	select tty, count(rxcui)::numeric as total
	from rxnorm.concepts
	-- where tty != 'SY' and tty!= 'TMSY'
	where sab = 'MTHSPL'
	group by tty
),
legitConcepts as (
	select rxcui, tty
	from rxnorm.concepts
	-- where tty != 'SY' and tty!= 'TMSY'
	where sab = 'MTHSPL'
	group by rxcui, tty
),
attributeObjectMap as (
	select rxcui, atn, count(atv) as card 
	from rxnorm.attributes
	where sab = 'MTHSPL'
	group by rxcui, atn
),
conceptAttributeMap as (
	select c.tty as st, count(c.rxcui)::numeric as numAttrUsesPerType, atn, max(card) as maxCard
	from legitConcepts as c 
		left join attributeObjectMap as a on c.rxcui = a.rxcui
	group by c.tty, atn
),
attributeObjectMap3 as (
	select st, 
		string_agg(
			'[DataMember] public ' ||
			case 
				when maxCard > 1 
				then 'List<string>' 
				else 'string' || case when numAttrUsesPerType/total < 1.0 then '?' else '' end
			end || ' ' || atn || ' { get; set; }', ' '
		) as attributes
	from conceptAttributeMap as c left join typeTotals as a on st = a.tty
	group by st
),
relationshipMap as (
	select rxcui2, rela, tty, count(rxcui1) as card 
	from rxnorm.relationships inner join legitConcepts on rxcui1 = rxcui
	where sab = 'MTHSPL'
	group by rxcui2, rela, tty
),
relationshipMap2 as (
	select c.tty as tty1, count(rxcui2) as numUsesPerType, rela, r.tty as tty2,  max(card) as maxCard 
	from legitConcepts as c left join relationshipMap as r on rxcui2 = rxcui
	group by c.tty, rela, r.tty
),
relationshipMap25 as (
	select tty1 as tty1x, rela as relax, count(tty2) as numOverrides
	from relationshipMap2
	group by tty1, rela
),
relationshipMap3 as (
	select tty1, string_agg('[DataMember] public ' ||
				case when maxCard > 1
				then 'List<' || replace(initcap(fullname), ' ', '') || '>'
				else replace(initcap(fullname), ' ', '') || case when numUsesPerType/total < 1.0 then '?' else '' end
				end || ' ' || replace(initcap(rela),'_','') || case when numOverrides > 1 then tty2 else '' end || ' { get; set; }',' ')
			as relationships
	from relationshipMap2 as c 
		left join typeTotals as a on tty1 = a.tty
		left join relationshipMap25 on (tty1x = tty1 and rela = relax)
		left join amann.termtypeabbreviations as abbr on tty2 = abbr.tty
	group by tty1
)
select '[DataContract] public class ' || replace(initcap(fullname),' ','') || ' { [DataMember] private int Id { get; set; } [DataMember] private string Name { get; set; } ' || attributes || ' ' || relationships || ' }' 
from relationshipMap3 
left join attributeObjectMap3 on st = tty1
left join amann.termtypeabbreviations as abbr on tty1 = abbr.tty
) to 'c:/postgresdata/datamodel.cs'
