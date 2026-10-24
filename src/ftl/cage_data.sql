drop table if exists tmp, peaks_bed, peaks_bed_f5;

#cage_experiments
insert into cage_experiments values('CEXP000001','Label:Control; AnimalID:U6; Lane:1; Index:CAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000002','Label:Control; AnimalID:U7; Lane:1; Index:GCG;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000003','Label:Control; AnimalID:U8; Lane:1; Index:TAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000004','Label:H24h; AnimalID:U26; Lane:2; Index:GCG;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000005','Label:H24h; AnimalID:U24; Lane:6; Index:ACC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000006','Label:H24h; AnimalID:U25; Lane:2; Index:CAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000007','Label:H3; AnimalID:U9; Lane:2; Index:TAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000008','Label:H3; AnimalID:U11; Lane:3; Index:CAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000009','Label:H3; AnimalID:U10; Lane:6; Index:CAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000010','Label:H7; AnimalID:U1; Lane:3; Index:GCG;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000011','Label:H7; AnimalID:U2; Lane:3; Index:TAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000012','Label:H7; AnimalID:U3; Lane:6; Index:AGT;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000013','Label:H7R24h; AnimalID:U21; Lane:4; Index:CAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000014','Label:H7R24h; AnimalID:U18; Lane:4; Index:GCG;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000015','Label:H7R24h; AnimalID:U20; Lane:4; Index:TAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000016','Label:H7R3; AnimalID:U5; Lane:5; Index:CAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000017','Label:H7R3; AnimalID:U16; Lane:5; Index:GCG;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000018','Label:H7R3; AnimalID:U4; Lane:6; Index:GCG;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000019','Label:H7R7; AnimalID:U12; Lane:5; Index:TAC;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000020','Label:H7R7; AnimalID:U13; Lane:6; Index:ATG;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000021','Label:H7R7; AnimalID:U19; Lane:6; Index:ACG;',5264,'Rattus norvegicus');
insert into cage_experiments values('CEXP000022','Label:Control; AnimalID:U6; Lane:1; Index:ACC;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000023','Label:Control; AnimalID:U7; Lane:1; Index:AGT;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000024','Label:Control; AnimalID:U8; Lane:1; Index:ATG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000025','Label:H24h; AnimalID:U24; Lane:1; Index:ACG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000026','Label:H24h; AnimalID:U25; Lane:2; Index:ACC;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000027','Label:H24h; AnimalID:U26; Lane:2; Index:AGT;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000028','Label:H3; AnimalID:U9; Lane:2; Index:ATG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000029','Label:H3; AnimalID:U10; Lane:2; Index:ACG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000030','Label:H3; AnimalID:U11; Lane:3; Index:ACC;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000031','Label:H7; AnimalID:U1; Lane:3; Index:AGT;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000032','Label:H7; AnimalID:U2; Lane:3; Index:ATG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000033','Label:H7; AnimalID:U3; Lane:3; Index:ACG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000034','Label:H7R24h; AnimalID:U21; Lane:4; Index:ACC;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000035','Label:H7R24h; AnimalID:U18; Lane:4; Index:AGT;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000036','Label:H7R24h; AnimalID:U20; Lane:4; Index:ATG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000037','Label:H7R3; AnimalID:U4; Lane:4; Index:ACG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000038','Label:H7R3; AnimalID:U5; Lane:5; Index:ACC;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000039','Label:H7R3; AnimalID:U16; Lane:5; Index:AGT;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000040','Label:H7R7; AnimalID:U12; Lane:5; Index:ATG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000041','Label:H7R7; AnimalID:U13; Lane:5; Index:ACG;',5263,'Rattus norvegicus');
insert into cage_experiments values('CEXP000042','Label:H7R7; AnimalID:U19; Lane:6; Index:TAC;',5263,'Rattus norvegicus');
#end of cage experiments

#cage_peaks, cage_peaks_annot

#  EDL cage_peaks, cage_peaks_annot
create table peaks_bed( chrom varchar(10), start int unsigned not null, end int unsigned not null, name TEXT, score float,  strand varchar(1), gene_id VARCHAR(20), gene_symbol TEXT);
load data local infile 'peaks.permissive.annotated.Ensembl+RefSeq_EDL.bed6_2' into table peaks_bed;
create INDEX name on peaks_bed(name(10));
insert into cage_peaks(chrom,start,end,strand,type,name,organism) select distinct chrom,start,end,strand,'EDL',name,'Rattus norvegicus' from peaks_bed;

insert into cage_peaks_annot select id,'ensembl_gene_id',gene_id from peaks_bed join cage_peaks using(name) where gene_id like 'ENSRNOG%' and cage_peaks.type='EDL';
insert into cage_peaks_annot select id,'entrez_gene_id',gene_id from peaks_bed join cage_peaks using(name) where gene_id REGEXP '[0-9]+' and cage_peaks.type='EDL';
insert into cage_peaks_annot select id,'gene_symbol',gene_symbol from peaks_bed join cage_peaks using(name) where gene_symbol != '.' and cage_peaks.type='EDL';

create table peaks_bed_f5( chrom varchar(10), start int unsigned not null, end int unsigned not null, name TEXT, score float,  strand varchar(1), fantom5_peak_id VARCHAR(20));
load data local infile 'peaks.permissive.annotated.F5_EDL.bed6_1' into table peaks_bed_f5;
create INDEX name on peaks_bed_f5(name(10));
insert into cage_peaks_annot select id,'fantom5_peak_id',fantom5_peak_id from peaks_bed_f5 join cage_peaks using(name) where fantom5_peak_id != '.' and cage_peaks.type='EDL';

truncate peaks_bed_f5;
load data local infile 'peaks.permissive.annotated.enhancers_EDL.bed6_1' into table peaks_bed_f5;
insert into cage_peaks_annot select id,'enhancer_id',fantom5_peak_id from peaks_bed_f5 join cage_peaks using(name) where fantom5_peak_id != '.' and cage_peaks.type='EDL';

#  end of EDL cage_peaks, cage_peaks_annot

truncate peaks_bed;
truncate peaks_bed_f5;

#  SOL cage_peaks, cage_peaks_annot
load data local infile 'peaks.permissive.annotated.Ensembl+RefSeq_SOL.bed6_2' into table peaks_bed;
insert into cage_peaks(chrom,start,end,strand,type,name,organism) select distinct chrom,start,end,strand,'SOL',name,'Rattus norvegicus' from peaks_bed;

insert into cage_peaks_annot select id,'ensembl_gene_id',gene_id from peaks_bed join cage_peaks using(name) where gene_id like 'ENSRNOG%' and cage_peaks.type='SOL';
insert into cage_peaks_annot select id,'entrez_gene_id',gene_id from peaks_bed join cage_peaks using(name) where gene_id REGEXP '[0-9]+' and cage_peaks.type='SOL';
insert into cage_peaks_annot select id,'gene_symbol',gene_symbol from peaks_bed join cage_peaks using(name) where gene_symbol != '.' and cage_peaks.type='SOL';

load data local infile 'peaks.permissive.annotated.F5_SOL.bed6_1' into table peaks_bed_f5;
insert into cage_peaks_annot select id,'fantom5_peak_id',fantom5_peak_id from peaks_bed_f5 join cage_peaks using(name) where fantom5_peak_id != '.' and cage_peaks.type='SOL';

truncate peaks_bed_f5;
load data local infile 'peaks.permissive.annotated.enhancers_SOL.bed6_1' into table peaks_bed_f5;
insert into cage_peaks_annot select id,'enhancer_id',fantom5_peak_id from peaks_bed_f5 join cage_peaks using(name) where fantom5_peak_id != '.' and cage_peaks.type='SOL';

#  end of SOL cage_peaks, cage_peaks_annot

drop table peaks_bed_f5;
drop table peaks_bed;

#end of cage_peaks, cage_peaks_annot


#cage_expr_table_edl

alter table cage_expr_table_edl add column name text;
create index name on cage_expr_table_edl(name(10));
load data local infile 'peakExpression200.col.EDL.tsv' into table cage_expr_table_edl(name,CEXP000001,CEXP000002,CEXP000003,CEXP000005,CEXP000006,CEXP000004,CEXP000009,CEXP000008,CEXP000007,CEXP000010,CEXP000011,CEXP000012,CEXP000014,CEXP000015,CEXP000013,CEXP000017,CEXP000018,CEXP000016,CEXP000019,CEXP000020,CEXP000021);
delete from cage_expr_table_edl where id=1;
alter table cage_expr_table_edl modify id int unsigned not null;
alter table cage_expr_table_edl drop primary key;
update cage_expr_table_edl join cage_peaks using(name) set cage_expr_table_edl.id=cage_peaks.id;
alter table cage_expr_table_edl add primary key(id);
alter table cage_expr_table_edl modify id int unsigned not null auto_increment;
alter table cage_expr_table_edl drop column name;

#end of cage_expr_table_edl


#cage_expr_table_sol

alter table cage_expr_table_sol add column name text;
create index name on cage_expr_table_sol(name(10));
load data local infile 'peakExpression200.col.SOL.tsv' into table cage_expr_table_sol(name,CEXP000022, CEXP000023, CEXP000024, CEXP000025, CEXP000026, CEXP000027, CEXP000029, CEXP000030, CEXP000028, CEXP000031, CEXP000032, CEXP000033, CEXP000035, CEXP000036, CEXP000034, CEXP000039, CEXP000037, CEXP000038, CEXP000040, CEXP000041, CEXP000042);
delete from cage_expr_table_sol where id=1;
alter table cage_expr_table_sol modify id int unsigned not null;
alter table cage_expr_table_sol drop primary key;
update cage_expr_table_sol join cage_peaks using(name) set cage_expr_table_sol.id=cage_peaks.id;
alter table cage_expr_table_sol add primary key(id);
alter table cage_expr_table_sol modify id int unsigned not null auto_increment;
alter table cage_expr_table_sol drop column name;

#end of cage_expr_table_sol

#cage_peaks_expression

#for f in $(seq 1 21); do printf "insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP%06d',CEXP%06d from cage_expr_table_edl;\n" $f $f; done
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000001',CEXP000001 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000002',CEXP000002 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000003',CEXP000003 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000004',CEXP000004 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000005',CEXP000005 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000006',CEXP000006 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000007',CEXP000007 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000008',CEXP000008 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000009',CEXP000009 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000010',CEXP000010 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000011',CEXP000011 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000012',CEXP000012 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000013',CEXP000013 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000014',CEXP000014 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000015',CEXP000015 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000016',CEXP000016 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000017',CEXP000017 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000018',CEXP000018 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000019',CEXP000019 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000020',CEXP000020 from cage_expr_table_edl;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000021',CEXP000021 from cage_expr_table_edl;
#for f in $(seq 22 42); do printf "insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP%06d',CEXP%06d from cage_expr_table_sol;\n" $f $f; done
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000022',CEXP000022 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000023',CEXP000023 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000024',CEXP000024 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000025',CEXP000025 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000026',CEXP000026 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000027',CEXP000027 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000028',CEXP000028 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000029',CEXP000029 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000030',CEXP000030 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000031',CEXP000031 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000032',CEXP000032 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000033',CEXP000033 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000034',CEXP000034 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000035',CEXP000035 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000036',CEXP000036 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000037',CEXP000037 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000038',CEXP000038 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000039',CEXP000039 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000040',CEXP000040 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000041',CEXP000041 from cage_expr_table_sol;
insert into cage_peaks_expression(peak_id,exp_id,value) select id,'CEXP000042',CEXP000042 from cage_expr_table_sol;

#end of cage_peaks_expression


#cage_enhancers
create table tmp (`chrom` varchar(10) DEFAULT NULL,   `start` int(10) unsigned NOT NULL,   `end` int(10) unsigned NOT NULL, `name` text,`strand` char(1) DEFAULT NULL);
load data local infile 'enhancers_EDL.interval' into table tmp;
insert into cage_enhancers(chrom,start,end,type,name) select distinct chrom,start,end,'EDL',name from tmp;
truncate tmp;
load data local infile 'enhancers_SOL.interval' into table tmp;
insert into cage_enhancers(chrom,start,end,type,name) select distinct chrom,start,end,'SOL',name from tmp;
drop table tmp;
#end of cage_enhancers

#cage_enhancers2genes

create table tmp (name text, `chrom` varchar(10), `start` int(10) unsigned,   `end` int(10) unsigned, ensembl_id varchar(20), t1 text, t2 text, t3 text, t4 text, corr float, padj float);
create index name on tmp(name(30));
load data local infile 'enhancers_corr_degs_SOL.tsv' into table tmp;
insert into cage_enhancers2genes select cage_enhancers.id,tmp.ensembl_id,'corr',corr,padj from tmp join cage_enhancers using(name) where type='SOL';
truncate tmp;
load data local infile 'enhancers_corr_degs_EDL.tsv' into table tmp;
insert into cage_enhancers2genes select cage_enhancers.id,tmp.ensembl_id,'corr',corr,padj from tmp join cage_enhancers using(name) where type='EDL';
drop table tmp;

create table tmp (name text, `chrom` varchar(10), `start` int(10) unsigned,   `end` int(10) unsigned, ensembl_id varchar(20), t1 text);
load data local infile 'enhancers_prox_genes_SOL.tsv' into table tmp;
insert into cage_enhancers2genes select cage_enhancers.id,tmp.ensembl_id,'prox',null,null from tmp join cage_enhancers using(name) where type='SOL';
truncate tmp;
load data local infile 'enhancers_prox_genes_EDL.tsv' into table tmp;
insert into cage_enhancers2genes select cage_enhancers.id,tmp.ensembl_id,'prox',null,null from tmp join cage_enhancers using(name) where type='EDL';
drop table tmp;

#end of cage_enhancers2genes




