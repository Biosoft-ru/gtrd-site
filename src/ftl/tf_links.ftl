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
