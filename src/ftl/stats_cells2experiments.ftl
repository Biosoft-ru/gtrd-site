DROP TABLE IF EXISTS stats_cells2experiments;

CREATE TABLE stats_cells2experiments 
(
	cell_id INT NOT NULL PRIMARY KEY,
	chip_seq  	          INT DEFAULT 0,
	chip_seq_control      INT DEFAULT 0,
	chip_exo  	  		  INT DEFAULT 0,
	chip_exo_control  	  INT DEFAULT 0,
    histone_marks         INT DEFAULT 0,
    histone_marks_control INT DEFAULT 0,
	dnase_seq 	          INT DEFAULT 0,
	atac_seq  	          INT DEFAULT 0,
	mnase_seq 	          INT DEFAULT 0,
	faire_seq 	          INT DEFAULT 0,
    tf_chip_seq	          INT DEFAULT 0,
    tf_chip_exo	          INT DEFAULT 0,
    rna_seq   	          INT DEFAULT 0,
    cage_seq              INT DEFAULT 0
)DEFAULT CHARSET=utf8;
   
INSERT INTO stats_cells2experiments(cell_id)
SELECT id FROM .cells;

<#assign control = " AND e.design_type IN ('bio-control', 'chip_control', 'chipexo_control', 'hist_control')" >

<#macro stats field type condition>
UPDATE stats_cells2experiments AS stats
INNER JOIN(
	SELECT cell_id, count(*) AS "cnt"
    FROM .experiments e
    WHERE e.type = '${type}'  ${condition}
    GROUP BY cell_id 
) AS exp USING (cell_id)
SET stats.${field} = exp.cnt;
</#macro>


<@stats 'chip_seq' 'ChIP-seq' ""/>
<@stats 'chip_seq_control' 'ChIP-seq' control/>

<@stats 'chip_exo' 'ChIP-exo' ""/>
<@stats 'chip_exo_control' 'ChIP-exo' control/>

<@stats 'histone_marks' 'Histone marks' ""/>
<@stats 'histone_marks_control' 'Histone marks' control/>

<@stats 'dnase_seq' 'DNase-seq' ""/>
<@stats 'atac_seq'  'ATAC-seq'  ""/>
<@stats 'mnase_seq' 'MNase-seq' ""/>
<@stats 'faire_seq' 'FAIRE-seq' ""/>

<@stats 'rna_seq'   'RNA-seq'   ""/>
<@stats 'cage_seq'  'CAGE-seq'  ""/>


-- TF & cofactors
UPDATE stats_cells2experiments AS stats
INNER JOIN(
	SELECT cell_id, count(distinct tf_uniprot_id) AS "cnt"
    FROM .experiments e
    WHERE e.type = 'ChIP-seq' AND e.design_type NOT IN ('chip_control', 'bio-control') AND e.tf_uniprot_id IS NOT NULL
    GROUP BY cell_id
) AS exp USING (cell_id)
SET stats.tf_chip_seq = exp.cnt;

UPDATE stats_cells2experiments AS stats
INNER JOIN(
	SELECT cell_id, count(distinct tf_uniprot_id) AS "cnt"
    FROM .experiments e
    WHERE e.type = 'ChIP-exo' AND e.design_type NOT IN ('chip_control', 'bio-control') AND e.tf_uniprot_id IS NOT NULL
    GROUP BY cell_id
) AS exp USING (cell_id)
SET stats.tf_chip_exo = exp.cnt;
