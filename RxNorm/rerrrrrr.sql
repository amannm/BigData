
with 
a as (
select count(rxcui), atn, avg(character_length(atv)) as content, var_pop(character_length(atv))
from rxnorm.attributes
group by atn
)
select * 
from a inner join rxnorm.docs on atn = value
where dockey = 'ATN'
order by var_pop desc

-- text blockyness = relatively low aspect ratio *  belongs to a large container