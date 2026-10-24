DROP TABLE IF EXISTS species;
CREATE TABLE species 
SELECT species, 
CASE 
 WHEN species='Arabidopsis thaliana' THEN 'at'
 WHEN species='Caenorhabditis elegans' THEN 'ce'
 WHEN species='Danio rerio' THEN 'dr'
 WHEN species='Drosophila melanogaster' THEN 'dm'
 WHEN species='Homo sapiens' THEN 'hs'
 WHEN species='Mus musculus' THEN 'mm'
 WHEN species='Rattus norvegicus' THEN 'rn'
 WHEN species='Saccharomyces cerevisiae' THEN 'sc'
 WHEN species='Schizosaccharomyces pombe' THEN 'sp' 
END AS "short_name"
FROM cells GROUP BY species ORDER BY species;


DROP TABLE IF EXISTS experiment_types;
CREATE TABLE experiment_types
(
  id VARCHAR(20) NOT NULL PRIMARY KEY,
  description TEXT NOT NULL,
  order_ INT NOT NULL
);

<#macro experiment order, type, description>
INSERT INTO experiment_types values(${type?str}, ${description?str}, ${order});
</#macro>

<@experiment 1, "ChIP-seq",      "ChIP-seq experiments to reveal binding sites for transcription factors ant their cofactors." />
<@experiment 2, "ChIP-exo",      "ChIP-exo experiments for precise identification of binding sites for transcription factors and their cofactors." />

<@experiment 3, "ATAC-seq",      "ATAC-seq experiments for identification of open chromatin regions." />
<@experiment 4, "DNase-seq",     "DNase-seq experiments for identification of open chromatin regions." />
<@experiment 5, "FAIRE-seq",     "FAIRE-seq experiments for identification of open chromatin regions." />
<@experiment 6, "MNase-seq",     "MNase-seq experiments for assessing nucleosome landscapes." />

<@experiment 7, "Histone marks", "ChIP-seq experiments to reveal histone marks." />

<@experiment 8, "RNA-seq",       "RNA-seq experiments with altered TF activity through (knock-out, knock-down), or various types of activation to reveal the TF target genes." />

<@experiment 9, "CAGE-seq",      "CAGE-seq experiments to reveal tarnscription start sites and level of their expression." />

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
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

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


CREATE INDEX species        on tf_links (specie(50));
CREATE INDEX animal_db      on tf_links (animal_db(40));
CREATE INDEX cis_bp         on tf_links (cis_bp(40));
CREATE INDEX tf_class       on tf_links (tf_class_id(40));
CREATE INDEX gtrd_uniprot   on tf_links (gtrd_uniprot_id(30));

ALTER TABLE tf_links ADD chip_seq INT, ADD chip_exo INT;
UPDATE tf_links AS tf
INNER JOIN(
    SELECT e.tf_uniprot_id AS "uniprot", count(*) AS "cnt"
    FROM experiments e
    WHERE e.type = 'ChIP-seq' AND e.design_type NOT IN ${control}  
    GROUP BY e.tf_uniprot_id
) AS exp ON tf.gtrd_uniprot_id = exp.uniprot
SET tf.chip_seq = exp.cnt;

UPDATE tf_links AS tf
INNER JOIN(
    SELECT e.tf_uniprot_id AS "uniprot", count(*) AS "cnt"
    FROM experiments e
    WHERE e.type = 'ChIP-exo' AND e.design_type NOT IN ${control}  
    GROUP BY e.tf_uniprot_id
) AS exp ON tf.gtrd_uniprot_id = exp.uniprot
SET tf.chip_exo = exp.cnt;
