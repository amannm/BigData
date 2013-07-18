copy (
with 

classObjects as (
	select 
		tty as className,
		rxaui as classifiedObject
		
	from rxnorm.concepts
	--where sab = 'RXNORM' and tty != 'SY' and tty != 'TMSY'
	where sab = 'MTHSPL'
	group by tty, rxaui
),
classTotals as (

	select 
		className, 
		count(classifiedObject)::numeric as classSize
	
	from classObjects
	group by className
),
objectAttributes as (
	select 
		rxaui as attributedObject, atn as attributeName,
		
		count(atv) as numValues, 
		avg(character_length(atv)) as avgValuesLength

	from rxnorm.attributes
	--where sab = 'RXNORM'
	where sab = 'MTHSPL'
	group by rxaui, atn
),
objectProperties as (
	select 
		rxaui2 as predecessor, coalesce(rela, string_agg(rel, ' ')) as propertyName, className as successorClassName,

		count(classifiedObject) as totalSuccessors
	
	from rxnorm.relationships inner join classObjects on rxaui1 = classifiedObject
	--where sab = 'RXNORM' and rel != 'SY'
	where sab = 'MTHSPL'
	group by rxaui2, rela, className
),

classAttributes as (
	select 
		className, attributeName,
		
		count(attributedObject)::numeric as totalAttributedObjects,
		
		min(numValues) as minCardinality,
		avg(numValues) as avgCardinality,
		max(numValues) as maxCardinality,
		stddev_pop(numValues) as sdCardinality,
		
		min(avgValuesLength) as minAvgFieldLength, 
		avg(avgValuesLength) as avgAvgFieldLength,
		max(avgValuesLength) as maxAvgFieldLength,
		stddev_pop(avgValuesLength) as sdAvgFieldLength
		
	from classObjects inner join objectAttributes on classifiedObject = attributedObject
	group by className, attributeName
),
classProperties as (
	select 
		className as predecessorClassName, propertyName, successorClassName, 
		
		count(predecessor) as totalPropertiedObjects, count(predecessor)::numeric/classSize as classPropertyFrequency, 

		min(totalSuccessors) as minSuccessors, 
		avg(totalSuccessors) as avgSuccessors, 
		max(totalSuccessors) as maxSuccessors,
		stddev_pop(totalSuccessors) as sdSuccessors
		
	from classObjects
		inner join objectProperties on classifiedObject = predecessor
		natural join classTotals
	group by className, classSize, propertyName, successorClassName
),
classAttributesDescription as (
	select 
		className,
		xmlelement(name attributes, 
			xmlagg(
				xmlelement(name attribute,
					xmlattributes(attributeName as "name", totalAttributedObjects as "total", to_char(totalAttributedObjects/classSize*100.0, 'FM999.999') as "frequency"), 
					xmlelement(name values,
						xmlattributes(minCardinality as "min", to_char(avgCardinality, 'FM99999.999') as "avg", maxCardinality as "max", to_char(sdCardinality, 'FM99999999.99999999') as "sd")
					),
					xmlelement(name content,
						xmlattributes(to_char(minAvgFieldLength, 'FM99999.999') as "min", to_char(avgAvgFieldLength, 'FM99999.999') as "avg", to_char(maxAvgFieldLength, 'FM99999.999') as "max", to_char(sdAvgFieldLength, 'FM99999999.99999999') as "sd")
					)
				)
			)
		) as attributesDescription
		
	from classAttributes natural join classTotals
	group by className
),
classPropertiesDescription as (
	select 
		predecessorClassName as className, 
		xmlelement(name properties,
			xmlagg(
				xmlelement(name property,
					xmlattributes(propertyName as "name", successorClassName as "parameter", totalPropertiedObjects as "total", to_char(classPropertyFrequency*100, 'FM999.999') as "frequency"),
					xmlelement(name cardinality,
						xmlattributes(minSuccessors as "min", to_char(avgSuccessors, 'FM99999.999') as "avg", maxSuccessors as "max", to_char(sdSuccessors, 'FM99999999.99999999') as "sd")
					)
				) 
			)
		) as propertiesDescription
	from classProperties -- natural join overloadedClassProperties
	group by predecessorClassName
)
select 
	xmlelement(name class, 
		xmlattributes(coalesce(rxnorm.formatTTY(className), className) as "name"),
		propertiesDescription,
		attributesDescription
	)
from classPropertiesDescription natural join classAttributesDescription
) to 'c:/postgresdata/mthspldescriptor.xml'

