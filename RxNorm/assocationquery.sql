select conc.str, abbr.expl, attr.atv
from rxnorm.concepts as conc
	join rxnorm.attributes as attr 
		join rxnorm.abbreviations as abbr 
		on attr.atn = abbr.value
	on attr.rxcui = conc.rxcui
limit 10
