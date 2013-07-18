
copy (
with 
uniqueconceptattributes as (
select c.tty as st, c.rxcui as s, a.atn as p, count(a.atv) as total
from rxnorm.concepts as c
	inner join rxnorm.attributes as a on c.rxcui = a.rxcui
group by c.tty, c.rxcui, a.atn

),
totals as (
select tty, count(rxcui)::numeric as tot
from rxnorm.concepts
group by tty
),
resultsoo as (
select st, p, count(s) as proptotals, min(total) as minfanout, avg(total) as avgfanout, max(total) as maxfanout, stddev_pop(total) as sd
from uniqueconceptattributes
group by st, p
)
select
st as "Class", 
p as "Property", 
proptotals as "Total class objects using property", 
tot as "Total class objects", 
proptotals/tot * 100.0 as "Percent of class objects using property", 
minfanout as "Min Fanout",
avgfanout as "Average Fanout",
maxfanout as "Max Fanout",
sd as "Standard Deviation of Fanout"
from resultsoo inner join totals on tty = st
)
to 'c:/postgresdata/attributesresults.csv' with (format csv);
	




