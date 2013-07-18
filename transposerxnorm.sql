with 
vocinsert as (
insert into ontopad.voc (name, description) values ('rxnorm', 'RxNorm, a standardized nomenclature for clinical drugs, is produced by the National Library of Medicine. In this context, a clinical drug is a pharmaceutical product given to (or taken by) a patient with a therapeutic or diagnostic intent. In RxNorm, the name of a clinical drug combines its ingredients, strengths, and form.')
returning id
),
coninsert as (
insert into ontopad.con (term, voc) 
	select distinct tty, id from rxnorm.concepts, vocinsert where tty != 'TMSY' and tty != 'SY'
returning id, term, voc
),
indinsert as (
insert into ontopad.ind (term, voc, extid)
select str, id, rxaui::integer, tty from rxnorm.concepts inner join coninsert on term = tty
returning id, voc, extid, anno
),
meminsert as (
insert into ontopad.mem (ind, con, voc, extid)
	select ind.id, con.id, ind.voc, ind.extid from indinsert as ind inner join coninsert as con on con.term = ind.anno
	returning ind, con
),
opainsert as (
insert into ontopad.opa (
)