
copy (
with 
uniqueconceptproperties as (
select c1.tty as st, rxcui2 as s, rela as p, c2.tty as ot, count(rxcui1) as total
from rxnorm.relationships
	inner join rxnorm.concepts as c1 on c1.rxcui = rxcui2
	inner join rxnorm.concepts as c2 on c2.rxcui = rxcui1
group by c1.tty, rxcui2, rela, c2.tty

),
resultsoo as (
select st, p, ot, max(total) > 1
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
	




