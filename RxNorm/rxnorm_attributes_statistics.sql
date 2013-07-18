copy (
	select 
		a.sab as "Source",
		tty as "Class",
		atn as "Name",
		count(atv) as "Total",
		min(character_length(atv)) as "Minimum Length", 
		avg(character_length(atv)) as "Average Length",
		max(character_length(atv)) as "Maximum Length",
		stddev_pop(character_length(atv)) as "Standard Deviation"

	from rxnorm.attributes as a
		inner join rxnorm.concepts as b on a.rxaui = b.rxaui
		left join rxnorm.docs on atn = value
	where dockey = 'ATN'
	group by a.sab, tty, atn
) to 'c:/postgresdata/statistics/rxnorm/attributeValueStatistics.csv' with (format csv, header)

