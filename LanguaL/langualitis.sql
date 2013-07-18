-- with 
-- asdf as (
-- select ftc, regexp_matches(additional_info, '(<)([A-Z]+)(>[^\[]*\[ITIS )([0-9]+)', 'g') as tax from langual.term
-- ),
-- asdf2 as (
-- select ftc, tax[2] as tax, tax[4] as taxid from asdf
-- )
-- select distinct tax from asdf2



select * from langual.term where additional_info ilike '%SCITRIBE%'

-- "PHY"
-- "SUBPHY"

-- "SUPCLASS"
-- "CLASS"
-- "INFCLASS"

-- "ORD"
-- "SUBORD"
-- "INFORD"

-- "SUPFAM"
-- "FAM"
-- "SUBFAM"

-- "TRI"
-- "TRIBE"

-- "GEN"

-- "NAM"
-- "SYN"
