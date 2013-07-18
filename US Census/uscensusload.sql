-- select * 
-- from uscensus.surnames
-- order by pctapi desc
-- where 
-- limit 100
-- update uscensus.surnames 
-- set (pctwhite, pctblack, pctapi, pctaian, pct2prace, pcthispanic) = (coalesce(pctwhite, 0.00), coalesce(pctblack, 0.00), coalesce(pctapi, 0.00), coalesce(pctaian, 0.00), coalesce(pct2prace, 0.00), coalesce(pcthispanic, 0.00))
drop table if exists uscensus.texas;
create table uscensus.texas (
a text,
b text,
c text,
d text,
e text,
total integer
);

copy uscensus.texas from 'C:/tx2010.sf1/tx000012010.sf1'
with (format csv);
alter table uscensus.texas 
drop a, drop b, drop c, drop d, drop e;