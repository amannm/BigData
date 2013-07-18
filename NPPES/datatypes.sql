CREATE TYPE individual_name AS (
	last varchar(35),
	first varchar(20),
	middle varchar(20),
	prefix varchar(5)
	suffix varchar(5),
	credential varchar(20)
);
CREATE TYPE address AS (
	firstline varchar(55),
	secondline varchar(55),
	city varchar(40),
	state varchar(40)
	postal varchar(20),
	country varchar(2),
	telephone varchar(20),
	fax varchar(20),
	email varchar
);
CREATE TYPE ratio AS (
    n       numeric,
    d       numeric
);

create table license (

};

create table provider (
npi integer,
replacementnpi integer,
address address,
enumerated date,
deactivated date
) inherits (rim.role);

create table providerorganization (
ein varchar(9),
lbn varchar(70),

) inherits (provider);

create table providerindividual (
name individual_name,
othername individual_name
) inherits (provider);

create table authorizedofficial (
name individual_name
) inherits (provider);