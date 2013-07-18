

CREATE OR REPLACE FUNCTION rxnorm.formatTTY(i character varying) RETURNS character varying AS $$
	declare 
		res record;
        BEGIN
		select into res expl from rxnorm.docs where dockey = 'TTY' and type = 'expanded_form' and value = i;
                RETURN regexp_replace(initcap(res.expl),'[^a-zA-Z]+','','g');
        END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rxnorm.lowerFirstChar(rela character varying) RETURNS character varying AS $$
        BEGIN
		return overlay(rela placing lower(substring(rela from 1 for 1)) from 1 for 1);
        END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rxnorm.createDatatypeString(isCollection boolean, isNullable boolean, fullTypeName character varying) RETURNS character varying AS $$
        BEGIN
		return
		case when isCollection
			then 'List<' || fullTypeName || '>'
			else fullTypeName || case when isNullable then  '?' else '' end
		end ;
        END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rxnorm.createAttributeDatatypeString(isCollection boolean, isNullable boolean) RETURNS character varying AS $$
        BEGIN
		return
		case when isCollection
			then 'List<string>'
			else 'string' || case when isNullable then  '?' else '' end
		end ;
        END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rxnorm.createPropertyField(rela character varying, tty character varying, dt character varying, isOverloaded boolean, isRequired boolean, isCollection boolean) RETURNS character varying AS $$
	declare 
		publicFieldName character varying;
		privateFieldName character varying;
		datatype character varying;
		annotationValue character varying;
	BEGIN
		if isCollection
			then datatype := 'List<' || dt || '>';
			else datatype := dt;
		end if;
		
		if isOverloaded
			then publicFieldName := replace(initcap(rela),'_','') || tty;
			else publicFieldName := replace(initcap(rela),'_','');
		end if;
		
		return 'private ' || datatype || ' ' || rxnorm.lowerFirstChar(publicFieldName) || '; ';
                
        END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION rxnorm.createAttributeField(atn character varying, isRequired boolean, isCollection boolean) RETURNS character varying AS $$
	declare 
		privateFieldName character varying;		
		datatype character varying;
		annotationValue character varying;
	BEGIN
	
		if isCollection
			then datatype := 'List<String>';
			else datatype := 'String';
		end if;
			
		return 'private ' || datatype || ' ' || atn || '; ';
        END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION rxnorm.outputJavaFile(packageName character varying, imports character varying, annotations character varying, classname character varying, attributes character varying, relationships character varying) RETURNS character varying AS $$
declare 
classText character varying;
path character varying;
	st character varying;
	BEGIN
	
		path := 'c:/postgresdata/' || classname || '.java';
		classText := 'package ' || packageName || ';' || imports || ' ' || annotations || ' public class ' || classname || ' implements Serializable { private int id; private String name; ' || attributes || ' ' || relationships || ' }';
		st := 'copy (select * from unnest(array[''' || classText || '''])) to ''' || path || ''';';
		execute st;
		return 'Saved class to ' || path;
        END;
$$ LANGUAGE plpgsql;

select rxnorm.createPropertyField('has_brandname', 'BN', rxnorm.formatTTY('BN'), true, true ,true) 
--select rxnorm.createPropertyField('SIZE', true, true);