CREATE OR REPLACE FUNCTION rxnorm.(i character varying) RETURNS character varying AS $$
	declare 
		res record;
        BEGIN
		select into res expl from rxnorm.docs where dockey = 'TTY' and type = 'expanded_form' and value = i;
                RETURN regexp_replace(initcap(res.expl),'[^a-zA-Z]+','','g');
        END;
$$ LANGUAGE plpgsql;


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
			then 'ObservableCollection<' || fullTypeName || '>'
			else fullTypeName || case when isNullable then  '?' else '' end
		end ;
        END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rxnorm.createAttributeDatatypeString(isCollection boolean, isNullable boolean) RETURNS character varying AS $$
        BEGIN
		return
		case when isCollection
			then 'ObservableCollection<string>'
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
		if isRequired 
			then annotationValue := '[DataMember(IsRequired = true)]';
			else annotationValue := '[DataMember]';
		end if;
	
		if isCollection
			then datatype := 'ObservableCollection<' || dt || '>';
			else datatype := dt;
		end if;
		
		if isOverloaded
			then publicFieldName := replace(initcap(rela),'_','') || tty;
			else publicFieldName := replace(initcap(rela),'_','');
		end if;
		
		privateFieldName := '_' || rxnorm.lowerFirstChar(publicFieldName);
		
		return 'private ' || datatype || ' ' || privateFieldName || '; ' ||
		annotationValue || ' public ' || datatype || ' ' || publicFieldName ||
		' {
' || 
		'get { return this.' || privateFieldName || '; } ' ||
		'set { this.SetProperty(ref this.' || privateFieldName || ', value); }' ||
		' }';
                
        END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION rxnorm.createAttributeField(atn character varying, isRequired boolean, isCollection boolean) RETURNS character varying AS $$
	declare 
		privateFieldName character varying;		
		datatype character varying;
		annotationValue character varying;
	BEGIN
		if isRequired 
			then annotationValue := '[DataMember(IsRequired = true)]';
			else annotationValue := '[DataMember]';
		end if;
	
		if isCollection
			then datatype := 'ObservableCollection<string>';
			else datatype := 'string';
		end if;
		
		privateFieldName := '_' || lower(atn);
			
		return 'private ' || datatype || ' ' || privateFieldName || '; ' ||
		annotationValue || ' public ' || datatype || ' ' || atn ||
		' { 
' || 
		'get { return this.' || privateFieldName || '; } ' ||
		'set { this.SetProperty(ref this.' || privateFieldName || ', value); }' ||
		' }';
                
        END;
$$ LANGUAGE plpgsql;

select rxnorm.createPropertyField('has_brandname', 'BN', rxnorm.formatTTY('BN'), true, true ,true) 
--select rxnorm.createPropertyField('SIZE', true, true);