<#assign SOURCE="gtrd_v1903">
<#assign TARGET="gtrd_current">

DROP TABLE IF EXISTS ${TARGET}.database_info;
CREATE TABLE ${TARGET}.database_info
(
  id VARCHAR(50) NOT NULL,
  species VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL,
  link VARCHAR(200),
  order_ INT NOT NULL
);

<#macro database order, species, database_id, name, link>
INSERT INTO ${TARGET}.database_info values(${database_id?str}, ${species?str}, ${name?str}, ${link?str}, ${order});
</#macro>

<@database 1,  "Homo sapiens",      "hgnc_id",              "HGNC, gene",          "<a href=https://www.genenames.org/data/gene-symbol-report/#!/hgnc_id/" />

<@database 10, "Homo sapiens",      "ensembl_gene_id",      "Ensembl, gene",       "<a href=http://www.ensembl.org/Homo_sapiens/Gene/Summary?g=" />
<@database 10, "Mus musculus",      "ensembl_gene_id",      "Ensembl, gene",       "<a href=http://www.ensembl.org/Mus_musculus/Gene/Summary?g=" />
<@database 10, "Rattus norvegicus"  "ensembl_gene_id",      "Ensembl, gene",       "<a href=http://www.ensembl.org/Rattus_norvegicus/Gene/Summary?db=core;g=" />

<@database 11, "Homo sapiens",      "ensembl_trancript_id", "Ensembl, transcript", "<a href=http://www.ensembl.org/Homo_sapiens/Transcript/Summary?db=core;t=" />
<@database 11, "Mus musculus",      "ensembl_trancript_id", "Ensembl, transcript", "<a href=http://www.ensembl.org/Mus_musculus/Transcript/Summary?db=core;t=" />
<@database 11, "Rattus norvegicus", "ensembl_trancript_id", "Ensembl, transcript", "<a href=http://www.ensembl.org/Rattus_norvegicus/Transcript/Summary?db=core;t=" />

<@database 20, "",                  "entrez_gene_id",       "Entrez, gene",        "<a href=https://www.ncbi.nlm.nih.gov/gene/" />

<@database 90, "",                  "fantom5_name",         "FANTOM5, promoter",   "" />

CREATE INDEX database_info_db      ON ${TARGET}.database_info(id);
CREATE INDEX database_info_species ON ${TARGET}.database_info(species);
