<#assign SOURCE="gtrd_v1903">
<#assign TARGET="gtrd_current">


<#macro cage suffix>

DROP TABLE IF EXISTS ${TARGET}.cage_peaks_${suffix};
CREATE TABLE ${TARGET}.cage_peaks_${suffix} SELECT * from ${SOURCE}.cage_peaks_${suffix};

CREATE INDEX cage_peaks_${suffix}_id       ON ${TARGET}.cage_peaks_${suffix}(id);
CREATE INDEX cage_peaks_${suffix}_chrom    ON ${TARGET}.cage_peaks_${suffix}(chrom);
CREATE INDEX cage_peaks_${suffix}_start    ON ${TARGET}.cage_peaks_${suffix}(start);
CREATE INDEX cage_peaks_${suffix}_end      ON ${TARGET}.cage_peaks_${suffix}(end);
CREATE INDEX cage_peaks_${suffix}_gene     ON ${TARGET}.cage_peaks_${suffix}(gene_symbol(30));
CREATE INDEX cage_peaks_${suffix}_enhancer ON ${TARGET}.cage_peaks_${suffix}(enhancer_id);
CREATE INDEX cage_peaks_${suffix}_fantom5  ON ${TARGET}.cage_peaks_${suffix}(fantom5_id(50));


DROP TABLE IF EXISTS ${TARGET}.cage_promoters_annotation_${suffix};
CREATE TABLE ${TARGET}.cage_promoters_annotation_${suffix} SELECT * from ${SOURCE}.cage_promoters_annotation_${suffix};

CREATE INDEX cage_promoters_annotation_${suffix}_peak  ON ${TARGET}.cage_promoters_annotation_${suffix}(peak_id);
CREATE INDEX cage_promoters_annotation_${suffix}_db_id ON ${TARGET}.cage_promoters_annotation_${suffix}(external_db_id(100));


DROP TABLE IF EXISTS ${TARGET}.cage_promoters2transcripts_${suffix};
CREATE TABLE ${TARGET}.cage_promoters2transcripts_${suffix} SELECT * from ${SOURCE}.cage_promoters2transcripts_${suffix};

CREATE INDEX cage_promoters2transcripts_${suffix}_peak          ON ${TARGET}.cage_promoters2transcripts_${suffix}(peak_id);
CREATE INDEX cage_promoters2transcripts_${suffix}_transcript_id ON ${TARGET}.cage_promoters2transcripts_${suffix}(ensembl_transcript_id);

DROP TABLE IF EXISTS ${TARGET}.cage_enhancers_${suffix};
CREATE TABLE ${TARGET}.cage_enhancers_${suffix} SELECT * from ${SOURCE}.cage_enhancers_${suffix};

CREATE INDEX cage_enhancers_${suffix}_id    ON ${TARGET}.cage_enhancers_${suffix}(id);
CREATE INDEX cage_enhancers_${suffix}_chrom ON ${TARGET}.cage_enhancers_${suffix}(chrom);
CREATE INDEX cage_enhancers_${suffix}_start ON ${TARGET}.cage_enhancers_${suffix}(start);
CREATE INDEX cage_enhancers_${suffix}_end   ON ${TARGET}.cage_enhancers_${suffix}(end);
CREATE INDEX cage_enhancers_${suffix}_name  ON ${TARGET}.cage_enhancers_${suffix}(name(50));

DROP TABLE IF EXISTS ${TARGET}.cage_enhancers2genes_${suffix};
CREATE TABLE ${TARGET}.cage_enhancers2genes_${suffix} SELECT * from ${SOURCE}.cage_enhancers2genes_${suffix};

CREATE INDEX cage_enhancers2genes_${suffix}_enhancer_id      ON ${TARGET}.cage_enhancers2genes_${suffix}(enhancer_id);
CREATE INDEX cage_enhancers2genes_${suffix}_ensemble_gene_id ON ${TARGET}.cage_enhancers2genes_${suffix}(ensembl_gene_id);


DROP TABLE IF EXISTS ${TARGET}.cage_peaks_expression_${suffix};
CREATE TABLE ${TARGET}.cage_peaks_expression_${suffix}
(
  `peak_id` int(10) unsigned NOT NULL,
  `exp_id` varchar(10) DEFAULT NULL,
  `value` float DEFAULT NULL,
  KEY `peak_id` (`peak_id`),
  KEY `exp_id` (`exp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO ${TARGET}.cage_peaks_expression_${suffix}(peak_id, exp_id, value)
	SELECT   ce.peak_id, ce.exp_id, ce.value
	FROM ${SOURCE}.cage_peaks_expression ce
	INNER JOIN ${SOURCE}.cage_peaks_${suffix} cp ON cp.id = ce.peak_id;
   
</#macro>

<@cage suffix="hg38" />
<@cage suffix="mm10" />
<@cage suffix="rn6" />





