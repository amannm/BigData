CREATE OR REPLACE FUNCTION rxnorm.class_o_class_rxnorm(text, text)
returns 
table (
	"Predecessor Type" character varying(20), 
	"SCDC" character varying[],
	"TMSY" character varying[],
	"BPCK" character varying[],
	"MIN" character varying[],
	"IN" character varying[],
	"BN" character varying[],
	"SCDF" character varying[],
	"SBD" character varying[],
	"DFG" character varying[],
	"SCDG" character varying[],
	"SBDF" character varying[],
	"SBDC" character varying[],
	"SBDG" character varying[],
	"SCD" character varying[],
	"SY" character varying[],
	"PIN" character varying[],
	"ET" character varying[],
	"GPCK" character varying[],
	"DF" character varying[]
) AS '$libdir/tablefunc','crosstab_hash' LANGUAGE C STABLE STRICT;