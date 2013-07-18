drop table if exists rxnorm.termtypeabbreviations ;
CREATE TABLE rxnorm.termtypeabbreviations (
   tty character varying(20), 
   fullname character varying(32), 
   PRIMARY KEY (tty)
);

INSERT INTO rxnorm.termtypeabbreviations VALUES
        ('BN','BrandName'),
('BPCK','BrandedDrugPack'),
('DF','DoseForm'),
('DFG','DoseFormGroup'),
('ET','EntryTerm'),
('GPCK','GenericDrugPack'),
('IN','Ingredient'),
('MIN','MultipleIngredients'),
('PIN','PreciseIngredient'),
('SBD','BrandedDrug'),
('SBDC','BrandedDrugStrength'),
('SBDF','BrandedDoseForm'),
('SBDG','BrandedDoseFormGroup'),
('SCD','ClinicalDrug'),
('SCDC','ClinicalDrugStrength'),
('SCDF','ClinicalDoseForm'),
('SCDG','ClinicalDoseFormGroup');