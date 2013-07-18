-- with propcard as (
-- select rxcui2, rela, tty as ot, count(rxcui1) > 1 as many
-- from rxnorm.relationships
-- 	inner join rxnorm.concepts on rxcui = rxcui1
-- where tty != 'SY' and tty != 'TMSY'
-- group by rxcui2, rela, tty
-- 
-- )
-- select tty, rela, ot, bool_or(many)
-- from propcard
-- 	inner join rxnorm.concepts on rxcui = rxcui2
-- where tty != 'SY' and tty != 'TMSY'
-- group by tty, rela, ot

copy (
with 
uniqueconceptproperties as (
select c1.tty as st, rxcui2 as s, rela as p, c2.tty as ot, count(rxcui1) as total
from rxnorm.relationships
	inner join rxnorm.concepts as c1 on c1.rxcui = rxcui2
	inner join rxnorm.concepts as c2 on c2.rxcui = rxcui1
group by c1.tty, rxcui2, rela, c2.tty

),
totals as (
select tty, count(rxcui)::numeric as tot
from rxnorm.concepts
group by tty
),
resultsoo as (
select st, p, ot, count(s) as proptotals, min(total) as minfanout, avg(total) as avgfanout, max(total) as maxfanout, stddev_pop(total) as sd
from uniqueconceptproperties
group by st, p, ot
)
select
st as "Class", 
p as "Property", 
ot as "Property parameter class", 
proptotals as "Total class objects using property", 
tot as "Total class objects", 
proptotals/tot * 100.0 as "Percent of class objects using property", 
minfanout as "Min Fanout",
avgfanout as "Average Fanout",
maxfanout as "Max Fanout",
sd as "Standard Deviation of Fanout"
from resultsoo inner join totals on tty = st
)
to 'c:/postgresdata/results.csv' with (format csv);
	




