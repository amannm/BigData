create table nppes.provider_license 
(
	id serial primary key,
	number varchar(20),
	state varchar(2)
);
create table nppes.taxonomy
(
	id serial primary key,
	code varchar(10),
	primary varchar(1)
);

create table nppes.provider_other_identifier
(
	id serial primary key,
	type varchar(2)
	state varchar(2),
	issuer varchar(80)
);


create table nppes.individual_identifier
(
	id serial primary key,
	last varchar(35),
	first varchar(20),
	middle varchar(20),
	prefix varchar(5)
	suffix varchar(5),
	credential varchar(20)
);

create table nppes.address 
(
	id serial primary key,
	firstline varchar(55),
	secondline varchar(55),
	city varchar(40),
	state varchar(40)
	postal varchar(20),
	country varchar(2),
	telephone varchar(20),
	fax varchar(20)
);
create table nppes.individual
(
	id serial primary key,
	name integer
);

create table nppes.individual_provider
(
	soleproprietor boolean,
	othername integer,
	gender varchar(1)
) inherits(nppes.individual);

create table nppes.individual_authorized_official
(
	id serial,
	title varchar(35),
	telephone varchar(20)
) inherits(nppes.individual);
create table nppes,organization 
(
	lbn varchar(70),
	ein 
);
create table nppes.organization_provider
(

	otherlbn varchar(70),
	gender varchar(1)
) inherits(nppes.individual);

create table provider 
(
	mailing_address integer,
	practice_address integer,
	
);