
with 
sourcea1 as (
	select c1.rxcui as sid, ttyt.tty as st, a.atn as p, a.sab as src, a.atv as val
	from rxnorm.concepts as c1 
		left join rxnorm.attributes as a
		on a.rxcui = c1.rxcui
		left join rxnorm.termtypeabbreviations as ttyt on c1.tty  = ttyt.tty
	where c1.tty  != 'SY' and c1.tty  != 'TMSY'
),
sourcea2 as (
	select sourcea1.st as st, sourcea1.p as p, sourcea1.src as src, count(sourcea1.val) as numval
	from sourcea1
	group by sourcea1.sid, sourcea1.st, sourcea1.p, sourcea1.src
),
sourcea5 as (
	select sourcea2.st as st, sourcea2.p as p, sourcea2.src as src, case when max(sourcea2.numval) > 1 then 'List<String>' else 'String' end as ot
	from sourcea2
	group by sourcea2.st, sourcea2.p, sourcea2.src
),
sourcea6 as (
select sourcea5.st as st, 'public class ' || sourcea5.src || ' { '|| string_agg('private ' || sourcea5.ot || ' ' || sourcea5.p || ';', ' ') || '}' as properties
from sourcea5 
group by sourcea5.st, sourcea5.src
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
	select ttytst.fullname as st, source1.p as p, ttytot.fullname as ot, count(source1.oid) as numo
	from source1 
		left join rxnorm.termtypeabbreviations as ttytst on source1.st = ttytst.tty
		left join rxnorm.termtypeabbreviations as ttytot on source1.ot = ttytot.tty
	group by source1.sid, source1.p, ttytst.fullname, ttytot.fullname
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
),
source5 as (
	select source3.st as st, 
	case when source4.poverloaded then replace(overlay(initcap(source3.p) placing lower(substring(source3.p from 1 for 1)) from 1 for 1),'_','')|| regexp_replace(source3.ot, '[a-z]', '', 'g') else replace(overlay(initcap(source3.p) placing lower(substring(source3.p from 1 for 1)) from 1 for 1),'_','')  end as p,
	 case when source3.omany then 'Set<' || source3.ot || '>' else source3.ot end as ot
	from source3
		left join source4
		on (source3.st = source4.st and source3.p = source4.p)
),
source6 as (
select source5.st as st, string_agg('private ' || source5.ot || ' ' || source5.p || ';', ' ') as links
from source5 
group by source5.st
)

select sourcea6.st, string_agg(sourcea6.properties, ' ')
from sourcea6 
group by sourcea6.st
	--inner join sourcea6 on source6.st = sourcea6.st