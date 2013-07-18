-- rela becomes columns

select * 
from rxnorm.class_o_class_rxnorm('
select c1.tty as tty1, c2.tty as tty2, string_agg(distinct rela)
from rxnorm.relationships as r
	inner join rxnorm.concepts as c1 on rxcui2 = c1.rxcui
	inner join rxnorm.concepts as c2 on rxcui1 = c2.rxcui
where c1.sab = ''RXNORM'' and c2.sab = ''RXNORM'' and r.sab = ''RXNORM''
group by 1,2
order by 1,2',
'select distinct tty from rxnorm.concepts where sab = ''RXNORM'''
) 