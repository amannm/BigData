﻿-- select distinct c1.tty, r.rela, c2.tty
-- from rxnorm.relationships as r 
-- 	inner join rxnorm.concepts as c1 on rxcui2 = c1.rxcui
-- 	inner join rxnorm.concepts as c2 on rxcui1 = c2.rxcui
-- where c1.sab = 'RXNORM' and r.sab = 'RXNORM' and c2.sab = 'RXNORM'
-- order by c1.tty, r.rela, c2.tty

-- select distinct c.tty, a.atn
-- from rxnorm.attributes as a
-- 	inner join rxnorm.concepts as c on a.rxcui = c.rxcui
-- where c.sab = 'RXNORM' and a.sab = 'RXNORM'
-- order by c.tty, a.atn