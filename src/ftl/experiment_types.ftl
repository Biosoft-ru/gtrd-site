DELETE FROM experiment_types;

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
 