
with 
sourcea1 as (
	select c1.rxcui as sid, c1.tty as st, a.atn as p, a.sab as src, a.atv as val,
	from rxnorm.concepts as c1 
		left join rxnorm.attributes as a
		on a.rxcui = c1.rxcui
	where c1.tty  != 'SY' and c1.tty  != 'TMSY'
),
sourcea2 as (
	select sourcea1.st as st, sourcea1.p as p, sourcea1.src as src, count(source1.val) as numval
	from sourcea1
	group by sourcea1.sid, sourcea1.st, sourcea1.p, sourcea1.src
),
sourcea3 as (
	select sourcea2.st as st, sourcea2.p as p, sourcea2.src as src, max(source2.numval) > 1 as valmany
	from sourcea2
	group by sourcea2.st, sourcea2.p, sourcea2.src
),
sourcea4 as (
	select sourcea3.st as st, sourcea3.p as p, sourcea3.valmany as valmany, count(sourcea3.src) > 1 as poverloaded
	from sourcea3
	group by sourcea3.st, sourcea3.p
),
sourcea5 as (
	select sourcea3.st as st, array_agg(sourcea3.p) as p, array_agg(sourcea3.valmany) as valmany, array_agg(sourcea4.poverloaded) as poverloaded
	from sourcea3
		left join sourcea4 as s4
		on (sourcea3.st = sourcea4.st and sourcea3.p = sourcea4.p)
	group by sourcea3.st
),
source1 as (
	select c1.rxcui as sid, c1.tty as st, r.rela as p, c2.rxcui as oid, c2.tty as ot
	from rxnorm.concepts as c1 
		left join rxnorm.relationships as r 
			left join rxnorm.concepts as c2
			on r.rxcui1 = c2.rxcui
		on r.rxcui2 = c1.rxcui
	where c1.tty  != 'SY' and c1.tty  != 'TMSY' and c2.tty != 'SY' and c2.tty != 'TMSY'
),
source2 as (
	select source1.st as st, source1.p as p, source1.ot as ot, count(source1.oid) as numo
	from source1
	group by source1.sid, source1.st, source1.p, source1.ot
),
source3 as (
	select source2.st as st, source2.p as p, source2.ot as ot, max(source2.numo) > 1 as omany
	from source2
	group by source2.st, source2.p, source2.ot
),
source4 as (
	select source3.st as st, source3.p as p, count(source3.ot) > 1 as poverloaded
	from source3
	group by source3.st, source3.p
)
source5 as (
	select source3.st as st, array_agg(source3.p) as p, array_agg(source3.omany) as omany, array_agg(source4.poverloaded) as poverloaded
	from source3
		left join source4 as s4
		on (source3.st = source4.st and source3.p = source4.p)
	group by s3.st
)
select
	'package com.amann.drugs; ' ||
	'import java.io.Serializable; import javax.persistence.Entity; import javax.persistence.Id; ' ||
	'@Entity ' ||
	'public class ' || s3.st || ' implements Serializable { ' ||
	'private static final long serialVersionUID = 1L; ' ||
	'@Id private long id; ' ||
	'private String name; ' ||
	string_agg(
		case when s3.omany 
			then '@OneToMany private Set<' || s3.ot || '>'
			else '@OneToOne private ' || s3.ot
		end || ' ' || replace(initcap(s3.p),'_', '') ||
		case when s4.poverloaded 
			then s3.ot || '; '
			else ';'
		end, ' '
	) || 
	 string_agg(
		case when s3.omany 
			then '@OneToMany private Set<' || s3.ot || '>'
			else '@OneToOne private ' || s3.ot
		end || ' ' || replace(initcap(s3.p),'_', '') ||
		case when s4.poverloaded 
			then s3.ot || '; '
			else ';'
		end, ' '
	) || 
	'}'
from source3 as s3
	inner join source4 as s4
	on (s3.st = s4.st and s3.p = s4.p)
group by s3.st