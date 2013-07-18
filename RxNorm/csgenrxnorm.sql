copy (
with 

legitConcepts as (
	select rxcui, tty
	from rxnorm.concepts
	where tty != 'SY' and tty != 'TMSY' and sab = 'RXNORM'
	group by rxcui, tty
),
typeTotals as (
	select tty as xtty, count(distinct rxcui)::numeric as total
	from legitConcepts
	group by tty
),
attrMap as (
	select rxcui, atn, count(atv) as card 
	from rxnorm.attributes
	where sab = 'RXNORM'
	group by rxcui, atn
),
conAttrMap as (
	select c.tty as st, count(c.rxcui)::numeric as numAttrUsesPerType, atn, max(card) as maxCard
	from legitConcepts as c 
		left join attrMap as a on c.rxcui = a.rxcui
	group by c.tty, atn
),
conAttrMap2 as (
	select st, string_agg(rxnorm.createAttributeField(atn, maxCard > 1, numAttrUsesPerType/total < 1.0),' ') as attributes
	from conAttrMap as c left join typeTotals on st = xtty
	group by st
),
conRelMap as (
	select rxcui2, rela, tty, count(rxcui1) as card 
	from rxnorm.relationships as r inner join legitConcepts on rxcui1 = rxcui
	where r.sab = 'RXNORM'
	group by rxcui2, rela, tty
),
conRelMap2 as (
	select c.tty as tty1, rela, r.tty as tty2, max(card) > 1 as isCollection, count(rxcui)::numeric/max(total) < 1.0 as isRequired
	from legitConcepts as c 
		left join conRelMap as r on rxcui2 = rxcui
		inner join typeTotals on c.tty = xtty
	group by c.tty, rela, r.tty
),
conRelMapCountAhead as (
	select tty1 as tty1x, rela as relax, count(tty2) > 1 as isOverloaded
	from conRelMap2
	group by tty1, rela
),
conRelMap3 as (
	select tty1, string_agg(rxnorm.createPropertyField(rela, tty2, rxnorm.formatTTY(tty2), isOverloaded, isRequired, isCollection),' ') as relationships
	from conRelMap2 left join conRelMapCountAhead on (tty1 = tty1x and rela = relax)
	group by tty1
)
select '[DataContract] public class ' || rxnorm.formatTTY(st) || ' : BindableBase { 
private int _id;' 
|| ' [DataMember(IsRequired = true)] public int Id {'
|| ' get { return this._id; }'
|| ' set { this.SetProperty(ref this._id, value); }'
|| ' }
private string _name; 
[DataMember(IsRequired = true)] public string Name {' 
|| ' get { return this._name; }'
|| ' set { this.SetProperty(ref this._name, value); } 
} '

|| attributes || ' ' || relationships || ' }' 

from conRelMap3 
inner join conAttrMap2 on st = tty1
) to 'c:/postgresdata/datamodel.cs'
