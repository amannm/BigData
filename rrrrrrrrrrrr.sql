with 

range as (
select rxcui as objectId, tty as className, str as objectName
from rxnorm.concepts
where sab = 'RXNORM' and tty != 'SY' and tty != 'TMSY'
),
domain as (
select objectId
from range
where className = 'BN'
),
totals as (
select count(*)::numeric as total
from domain
),
properties as (
select rxcui2 as predecessorId, coalesce(rela, rel) as propertyName, className as successorClassName, count(rxcui1) as numSuccessors
from rxnorm.relationships inner join range on rxcui1 = objectId
where sab = 'RXNORM' and rel != 'SY'
group by rxcui2, rel, rela, className
),
attributes as (
select rxcui as objectId, atn as attributeName, count(atv) as numSuccessors, avg(character_length(atv)) as avgCharacterLength
from rxnorm.attributes
where sab = 'RXNORM'
group by rxcui, atn
),
propertiesColumns as (
select propertyName as columnName, count(objectId)/(select total from totals) = 1 as notnull, successorClassName, max(numSuccessors) > 1 as many
from properties inner join domain on objectId = predecessorId
group by propertyName, successorClassName
),
attributesColumns as (
select attributeName as columnName, count(objectId)/(select total from totals) = 1 as notnull, avg(avgCharacterLength) as avgCharacterLength, max(numSuccessors) > 1 as many
from attributes natural join domain
group by attributeName
)
select * from attributesColumns