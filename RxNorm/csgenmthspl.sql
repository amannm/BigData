copy (
with 

legitConcepts as (
	select rxaui, tty
	from rxnorm.concepts
	where sab = 'MTHSPL'
	group by rxaui, tty
),
typeTotals as (
	select tty as xtty, count(rxaui)::numeric as total
	from legitConcepts
	group by tty
),

-- Data Properties
-- 1. Group by unique objectid-property pairs. Collapse into value set and expose all individual-wise sizes
attrMap as (
	select rxaui, atn, count(atv) as card
	from rxnorm.attributes
	where sab = 'MTHSPL'
	group by rxaui, atn
),
-- 2. Join and group by objecttype-property pairs
conAttrMap as (
	select c.tty as st, count(c.rxaui)::numeric as numAttrUsesPerType, atn, avg(card) as avgFanout, max(card) as maxFanout, avg(character_length(atv)) as avgValueLength
	from legitConcepts as c 
		left join attrMap as a on c.rxaui = a.rxaui
	group by c.tty, atn
),
-- 3. Group by objecttype, aggregates all data properties of each object type
conAttrMap2 as (
	select st, string_agg(rxnorm.createAttributeField(atn, maxFanout > 1, numAttrUsesPerType/total < 1.0),' ') as attributes
	from conAttrMap as c left join typeTotals on st = xtty
	group by st
),

-- Object Properties
conRelMap as (
	select rxaui2, rela, tty, count(rxaui1) as card 
	from rxnorm.relationships as r inner join legitConcepts on rxaui1 = rxaui
	where r.sab = 'MTHSPL'
	group by rxaui2, rela, tty
),
conRelMap2 as (
	select c.tty as tty1, rela, r.tty as tty2, max(card) > 1 as isCollection, count(rxaui)::numeric/max(total) < 1.0 as isRequired
	from legitConcepts as c 
		left join conRelMap as r on rxaui2 = rxaui
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
) to 'c:/postgresdata/datamodelmthspl.cs'
