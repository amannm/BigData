-- with asdf as (
-- select distinct c1.tty as x, lower(coalesce(nullif(rela, ''), nullif(rel, ''), '?')) as y, c2.tty as z from ndfrt.relationships
-- inner join ndfrt.concepts as c1 on rxaui2 = c1.rxaui
-- inner join ndfrt.concepts as c2 on rxaui1 = c2.rxaui
-- )
-- select x, y, array_agg(z) from asdf group by x, y
select distinct str from ndfrt.concepts where tty = 'HT'