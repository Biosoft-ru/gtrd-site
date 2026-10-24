-- Migration: MyISAM -> InnoDB for gtrd_current
-- Run as: mysql -u gtrd -p gtrd_current < migrate_myisam_to_innodb.sql
-- Or via Python: pymysql and execute each statement

SET FOREIGN_KEY_CHECKS = 0;

-- Large tables (most critical for JOIN/DML performance)
ALTER TABLE tfmod_rna_expression ENGINE=InnoDB;
ALTER TABLE files_info ENGINE=InnoDB;
ALTER TABLE properties ENGINE=InnoDB;
ALTER TABLE hub ENGINE=InnoDB;
ALTER TABLE external_refs ENGINE=InnoDB;
ALTER TABLE experiments ENGINE=InnoDB;
ALTER TABLE cells ENGINE=InnoDB;
ALTER TABLE chip_experiments ENGINE=InnoDB;
ALTER TABLE hist_experiments ENGINE=InnoDB;
ALTER TABLE cage_experiments ENGINE=InnoDB;
ALTER TABLE chipexo_experiments ENGINE=InnoDB;
ALTER TABLE atac_experiments ENGINE=InnoDB;
ALTER TABLE dnase_experiments ENGINE=InnoDB;
ALTER TABLE faire_experiments ENGINE=InnoDB;
ALTER TABLE mnase_experiments ENGINE=InnoDB;
ALTER TABLE tfmod_rna_experiments ENGINE=InnoDB;

-- CAGE tables - hg38 (human, largest)
ALTER TABLE cage_peaks_hg38 ENGINE=InnoDB;
ALTER TABLE cage_promoters_annotation_hg38 ENGINE=InnoDB;
ALTER TABLE cage_enhancers_hg38 ENGINE=InnoDB;
ALTER TABLE cage_promoters2transcripts_hg38 ENGINE=InnoDB;
ALTER TABLE cage_enhancers2genes_hg38 ENGINE=InnoDB;

-- CAGE tables - rn6 (rat)
ALTER TABLE cage_peaks_rn6 ENGINE=InnoDB;
ALTER TABLE cage_promoters_annotation_rn6 ENGINE=InnoDB;
ALTER TABLE cage_enhancers_rn6 ENGINE=InnoDB;
ALTER TABLE cage_promoters2transcripts_rn6 ENGINE=InnoDB;
ALTER TABLE cage_enhancers2genes_rn6 ENGINE=InnoDB;

-- CAGE tables - mm10 (mouse)
ALTER TABLE cage_peaks_mm10 ENGINE=InnoDB;
ALTER TABLE cage_promoters_annotation_mm10 ENGINE=InnoDB;
ALTER TABLE cage_enhancers_mm10 ENGINE=InnoDB;
ALTER TABLE cage_promoters2transcripts_mm10 ENGINE=InnoDB;
ALTER TABLE cage_enhancers2genes_mm10 ENGINE=InnoDB;

-- CAGE tables - hg19 (human legacy)
ALTER TABLE cage_peaks_hg19 ENGINE=InnoDB;
ALTER TABLE cage_promoters_annotation_hg19 ENGINE=InnoDB;
ALTER TABLE cage_enhancers_hg19 ENGINE=InnoDB;
ALTER TABLE cage_promoters2transcripts_hg19 ENGINE=InnoDB;
ALTER TABLE cage_enhancers2genes_hg19 ENGINE=InnoDB;

-- CAGE tables - mm9 (mouse legacy)
ALTER TABLE cage_peaks_mm9 ENGINE=InnoDB;
ALTER TABLE cage_promoters_annotation_mm9 ENGINE=InnoDB;
ALTER TABLE cage_enhancers_mm9 ENGINE=InnoDB;
ALTER TABLE cage_promoters2transcripts_mm9 ENGINE=InnoDB;
ALTER TABLE cage_enhancers2genes_mm9 ENGINE=InnoDB;

-- CAGE tables - galgal5/6 (chicken)
ALTER TABLE cage_peaks_galgal5 ENGINE=InnoDB;
ALTER TABLE cage_promoters_annotation_galgal5 ENGINE=InnoDB;
ALTER TABLE cage_enhancers_galgal5 ENGINE=InnoDB;
ALTER TABLE cage_promoters2transcripts_galgal5 ENGINE=InnoDB;
ALTER TABLE cage_enhancers2genes_galgal5 ENGINE=InnoDB;

ALTER TABLE cage_peaks_galgal6 ENGINE=InnoDB;
ALTER TABLE cage_promoters_annotation_galgal6 ENGINE=InnoDB;
ALTER TABLE cage_enhancers_galgal6 ENGINE=InnoDB;
ALTER TABLE cage_promoters2transcripts_galgal6 ENGINE=InnoDB;
ALTER TABLE cage_enhancers2genes_galgal6 ENGINE=InnoDB;

-- CAGE tables - canfam3 (dog)
ALTER TABLE cage_peaks_canfam3 ENGINE=InnoDB;
ALTER TABLE cage_promoters_annotation_canfam3 ENGINE=InnoDB;
ALTER TABLE cage_enhancers_canfam3 ENGINE=InnoDB;
ALTER TABLE cage_promoters2transcripts_canfam3 ENGINE=InnoDB;
ALTER TABLE cage_enhancers2genes_canfam3 ENGINE=InnoDB;

-- CAGE tables - rheMac8 (monkey)
ALTER TABLE cage_peaks_rhemac8 ENGINE=InnoDB;
ALTER TABLE cage_promoters_annotation_rhemac8 ENGINE=InnoDB;
ALTER TABLE cage_enhancers_rhemac8 ENGINE=InnoDB;
ALTER TABLE cage_promoters2transcripts_rhemac8 ENGINE=InnoDB;
ALTER TABLE cage_enhancers2genes_rhemac8 ENGINE=InnoDB;

-- Remaining small tables
ALTER TABLE article ENGINE=InnoDB;
ALTER TABLE author ENGINE=InnoDB;
ALTER TABLE article_to_author ENGINE=InnoDB;
ALTER TABLE journal ENGINE=InnoDB;
ALTER TABLE classification ENGINE=InnoDB;
ALTER TABLE geo_series_rejected ENGINE=InnoDB;
ALTER TABLE missing_aligns ENGINE=InnoDB;
ALTER TABLE cage_expr_table_edl ENGINE=InnoDB;
ALTER TABLE cage_build_history_hg38 ENGINE=InnoDB;
ALTER TABLE cage_build_history_rn6 ENGINE=InnoDB;
ALTER TABLE cage_build_history_mm10 ENGINE=InnoDB;
ALTER TABLE cage_build_history_galgal6 ENGINE=InnoDB;
ALTER TABLE y ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;
