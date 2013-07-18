with rangesig as (
select c1.tty as st, rela as p, c2.tty as ot, count(rxcui1) > 1 as many
from rxnorm.relationships
	inner join rxnorm.concepts as c1 on c1.rxcui = rxcui2
	inner join rxnorm.concepts as c2 on c2.rxcui = rxcui1
group by c1.tty, rxcui2, rela, c2.tty
),
rangesig2 as (
select s, p, num
from rangesig 
group by s, p
limit 100
),
rangesig3 as (
select s, xmlelement(name properties, xmlagg(pot)) as sig
from rangesig2
group by s
limit 100
),
rangesig4 as (
select xmlelement(name conceptType, xmlattributes(tty as "type"), xmlagg(sig)) 
from rxnorm.concepts left join rangesig3 on rxcui = s
group by tty
limit 100
)
select * from rangesig4
limit 100