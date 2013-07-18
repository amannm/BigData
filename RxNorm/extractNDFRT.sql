create table ndfrt.concepts as select * from rxnorm.concepts where sab = 'NDFRT';
delete from rxnorm.concepts where sab = 'NDFRT';

create table ndfrt.relationships as select * from rxnorm.relationships where sab = 'NDFRT';
delete from rxnorm.relationships where sab = 'NDFRT';

create table ndfrt.attributes as select * from rxnorm.attributes where sab = 'NDFRT';
delete from rxnorm.attributes where sab = 'NDFRT';

