DROP TABLE IF EXISTS experiments;
CREATE TABLE experiments
(
  `id` VARCHAR(20) NOT NULL PRIMARY KEY,
  `type` VARCHAR(20) NOT NULL,
  `species` VARCHAR(50) NOT NULL,
  `cell_id` INT NOT NULL,
  `treatment` TEXT,
  `design_type` VARCHAR(20),
  `control_id` VARCHAR(20), 
  `antibody` TEXT, 
  `tf_uniprot_id` VARCHAR(10),
  `target` VARCHAR(20),
  `source` VARCHAR(20),
   `geo_gse` VARCHAR(20),
   `geo_gsm` VARCHAR(20)
)DEFAULT CHARSET=utf8;

INSERT INTO experiments(type, id, species, cell_id, treatment, design_type,     control_id, antibody, tf_uniprot_id)
                   SELECT   'ChIP-seq', id, specie,  cell_id, treatment, experiment_type, control_id, antibody, tf_uniprot_id
                   FROM chip_experiments;

INSERT INTO experiments(type, id, species, cell_id, treatment, design_type,     control_id, antibody, tf_uniprot_id)
                   SELECT   'ChIP-exo', id, specie,  cell_id, treatment, experiment_type, control_id, antibody, tf_uniprot_id
                   FROM chipexo_experiments;

INSERT INTO experiments(type, id, species,  cell_id, treatment)
                   SELECT   'ATAC-seq', id, organism, cell_id, treatment
                   FROM atac_experiments;

INSERT INTO experiments(type, id, species,  cell_id, treatment)
                   SELECT  'DNase-seq', id, organism, cell_id, treatment
                   FROM dnase_experiments;

INSERT INTO experiments(type, id, species,  cell_id, treatment)
                   SELECT  'FAIRE-seq', id, organism, cell_id, treatment
                   FROM faire_experiments;

INSERT INTO experiments(type, id, species,  cell_id, treatment)
                   SELECT  'MNase-seq', id, organism, cell_id, treatment
                   FROM mnase_experiments;

INSERT INTO experiments(type, id, species, cell_id, treatment, design_type,     control_id, antibody, target)
                   SELECT   'Histone marks', id, specie,  cell_id, treatment, experiment_type, control_id, antibody, target
                   FROM hist_experiments;

INSERT INTO experiments(type, id, species, cell_id, treatment)
                   SELECT   'CAGE-seq', id, species, cell_id, treatment
                   FROM cage_experiments;

INSERT INTO experiments(type, id, species,  cell_id, treatment, design_type,     control_id, tf_uniprot_id)
                   SELECT   'RNA-seq',  id, organism, cell_id, treatment, experiment_type, control_id, tf_uniprot_id
                   FROM tfmod_rna_experiments;

UPDATE experiments e
  INNER JOIN external_refs er1 ON er1.id = e.id AND er1.external_db='GEO' AND er1.external_db_id like 'GSE%' 
  INNER JOIN external_refs er2 ON er2.id = e.id AND er2.external_db='GEO' AND er2.external_db_id like 'GSM%'
  SET e.geo_gse = er1.external_db_id, e.geo_gsm = er2.external_db_id;

CREATE INDEX cell_id on experiments (cell_id);
CREATE INDEX tf_uniprot_id on experiments (tf_uniprot_id);
CREATE INDEX geo_gse on experiments (geo_gse);
CREATE INDEX geo_gsm on experiments (geo_gsm);

