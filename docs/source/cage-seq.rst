********
CAGE-seq
********


Integration with FANTOM5 data
-----------------------------
From a user view point it will be more convenient when CAGE-seq data will be integrated one with other and with FANTOM5 data. 

Main ideas are following:

* to build merged set of TSSs from FANTOM5 and obtained data;
* when TSSs are overlapping in FANTOM5 and obtained data, then maximally preserve FANTOM5 TSSs and in rare cases add new TSSs. 
  This is the most sophisticated part. See its description below.
* using the joined set of TSSs to build the joined table of TSSs expressions using FANTOM5 and new data. 
  For this purpose we are recalculating TSSs expressions using their joined set. Due to the suggested approach all FANTOM5 data will be preserved and seamlessly extended by the new data.
* annotate new TSSs using the same approach as FANTOM5. All FANTOM5 data also will be preserved and seamlessly extended by the new data.
* while FANTOM5 does not provide enhancers and their annotation for CAGE-seq data for rat, we are building a set of enhancers using both FANTOM5 and our data.
  to provide a unique ID for each TSS, enhancer and promoter so a user can unambiguously refer to them.

The suggested approach can be used for incremental integration of other CAGE-seq data with FANTOM5 data. 


Organisms
---------
The GTRD database and FANTOM5 contains corresponding data for different organisms.

The table below shows species in the GTRD database and FANTOM5.

Currently we include in the GTRD database CAGE-seq from FANTOM5 for 3 common species only: Homo sapiens, Mus musculus and Rattus norvegicus.

.. list-table:: 
   :header-rows: 1
   :widths: 25, 10, 10, 20

   * - Species
     - GTRD
     - FANTOM5
     - Comment
   * - Arabidopsis thaliana
     - +
     -
     -
   * - Caenorhabditis elegans, nematode
     - +
     -
     -
   * - Danio rerio, zebrafish
     - +
     -
     -
   * - Drosophila melanogaster, fruit fly
     - +
     -
     -
   * - Homo sapiens, human
     - +
     - +
     -
   * - Mus musculus, mouse
     - +
     - +
     -
   * - Rattus norvegicus, rat
     - +
     - +
     -
   * - Saccharomyces cerevisiae, budding yeast
     - +
     -
     -
   * - Schizosaccharomyces pombe, fission yeast
     - +
     -
     -
   * - Canis familiaris, dog 
     - 
     - +
     - possibly will be added in GTRD next releases
   * - Gallus gallus, chicken
     - 
     - +
     - possibly will be added in GTRD next releases
   * - Macaca mulatta, rhesus macaque
     - 
     - +
     - possibly will be added in GTRD next releases

     
FANTOM5 data import
-------------------
Table below specifies FANTOM5 files that were imported into the GTRD database.

.. list-table:: 
   :header-rows: 1
   :widths: 15, 65, 20

   * - Species
     - FANTOM5 directory, files
     - Comments
   * - Homo sapiens
     - https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/
      
       + peaks - `hg38_fair+new_CAGE_peaks_phase1and2.bed.gz <https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/CAGE_peaks/hg38_fair+new_CAGE_peaks_phase1and2.bed.gz>`_
       + annotation - `hg38_fair+new_CAGE_peaks_phase1and2_ann.txt.gz <https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/CAGE_peaks_expression/hg38_fair+new_CAGE_peaks_phase1and2_ann.txt.gz>`_
       + enhancers - `F5.hg38.enhancers.bed.gz <https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/enhancer/F5.hg38.enhancers.bed.gz>`_
       + expression - `hg38_fair+new_CAGE_peaks_phase1and2_counts.osc.txt.gz <https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/CAGE_peaks_expression/hg38_fair+new_CAGE_peaks_phase1and2_counts.osc.txt.gz>`_
       + experiment description - `HumanSamples2.0.sdrf.xlsx <https://fantom.gsc.riken.jp/5/datafiles/latest/basic/HumanSamples2.0.sdrf.xlsx>`_

     -
   * - Mus musculus
     - https://fantom.gsc.riken.jp/5/datafiles/reprocessed/mm10_v8/extra/

       + peaks - `mm10_fair+new_CAGE_peaks_phase1and2.bed.gz <https://fantom.gsc.riken.jp/5/datafiles/reprocessed/mm10_v8/extra/CAGE_peaks/mm10_fair+new_CAGE_peaks_phase1and2.bed.gz>`_
       + annotation - `mm10_fair+new_CAGE_peaks_phase1and2_ann.txt.gz <https://fantom.gsc.riken.jp/5/datafiles/reprocessed/mm10_v8/extra/CAGE_peaks_expression/mm10_fair+new_CAGE_peaks_phase1and2_ann.txt.gz>`_
       + enhancers - `F5.mm10.enhancers.bed.gz <https://fantom.gsc.riken.jp/5/datafiles/reprocessed/mm10_v8/extra/enhancer/F5.mm10.enhancers.bed.gz>`_
       + expression - `mm10_fair+new_CAGE_peaks_phase1and2_counts.osc.txt.gz <https://fantom.gsc.riken.jp/5/datafiles/reprocessed/mm10_v8/extra/CAGE_peaks_expression/mm10_fair+new_CAGE_peaks_phase1and2_counts.osc.txt.gz>`_
       + experiment description - `MouseSamples2.3.sdrf.txt <https://fantom.gsc.riken.jp/5/datafiles/latest/basic/MouseSamples2.3.sdrf.txt>`_

     -
   * - Rattus norvegicus
     - https://fantom.gsc.riken.jp/5/datafiles/latest/extra/CAGE_peaks

       + peaks - `rn6.cage_peak_coord.bed.gz <https://fantom.gsc.riken.jp/5/datafiles/latest/extra/CAGE_peaks/rn6.cage_peak_coord.bed.gz>`_
       + annotation - `rn6.cage_peak_ann.txt.gz <https://fantom.gsc.riken.jp/5/datafiles/latest/extra/CAGE_peaks/rn6.cage_peak_ann.txt.gz>`_
       + enhancers - are missing in FANTOM5
       + expression - `rn6.cage_peak_counts.osc.txt.gz <https://fantom.gsc.riken.jp/5/datafiles/latest/extra/CAGE_peaks/rn6.cage_peak_counts.osc.txt.gz>`_
       + experiment description - `RatSamples2.1.sdrf.txt <https://fantom.gsc.riken.jp/5/datafiles/latest/basic/RatSamples2.1.sdrf.txt>`_

     -

CAGE peaks annotation
---------------------

If CAGE peak is located near with known gene TSS then it is annotated as promoter.

Also such peak is annotated with hyperlinks to corresponding transript/gene/protein identifier in the external database.

For each specie its own set of databases is used as shown in table below. 

Column comments: 
 * Database, entity -  database name and correspondin entity type (transript/gene/protein)
 * FANTOM5 - indicates whether references to this database are used in annotation by FANTOM5
 * GTRD, FANTOM5    - indicates whether references to this database are used in GTRD for CAGE peaks imported from FANTOM5
 * GTRD, new peaks  - indicates whether references to this database are used for annotation of new CAGE peaks in GTRD

.. list-table:: 
   :header-rows: 1
   :widths: 15, 20, 10, 10, 10, 35

   * - Species
     - Database, entity 
     - FANTOM5
     - GTRD, FANTOM5
     - GTRD, new peaks
     - Description, comment
   * - Homo sapiens
     - Ensembl, transcript id
     - +
     - +
     - +
     - 
   * - 
     - Ensembl, gene id 
     - +
     - +
     - +
     - ``duplicates cage_promoters2transcripts``?
   * - 
     - Entrez, gene id
     - +
     - +
     - +
     - 
   * - 
     - HGNC, gene id
     - +
     - +
     - +
     - 
   * - 
     - FANTOM5, peak id 
     - +
     - +
     - +
     - ``duplicates cage_peaks_xx.fantom5_id``?
   * -
     - Associated gene name
       Associated gene symbol
       Associated gene synonym
       Source of associated gene
     - +
     - 
     - 
     -

   * - Mus musculus
     - Ensembl, transcript id
     - +
     - +
     - +
     - 
   * - 
     - Ensembl, gene id 
     - +
     - +
     - +
     - ``duplicates cage_promoters2transcripts``?
   * - 
     - Entrez, gene id
     - +
     - +
     - +
     - 
   * - 
     - FANTOM5, peak id 
     - +
     - +
     - +
     - ``duplicates cage_peaks_xx.fantom5_id``?
   * -
     - Associated gene name
       Associated gene symbol
       Associated gene synonym
       Source of associated gene
     - +
     -
     -
     -

   * - Rattus norvegicus
     - Ensembl, gene id
     - +
     - +
     - +
     - 
   * - 
     - Ensembl, transcript id 
     - +
     - +
     - +
     - ``duplicates cage_promoters2transcripts``?
   * -
     - Ensembl_gene_name
       Augustus_gene_name
       RefSeq_transcript_id
       Geneid_gene_name
       Genscan_gene_name
       EST_gene_name
     - +
     - ?
     -
     -

Database schema
----------------

Results of analyses of CAGE-seq data presented as a set of SQL tables.

These tables are populated for each species, where xx is suffix that specifies specie and genome build.

.. list-table:: 
   :header-rows: 1
   :widths: 15, 20, 40

   * - Table suffix
     - Species
     - Genome build
   * - hg38
     - Homo sapiens, human
     - https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.26
   * - mm10
     - Mus musculus, mouse
     - https://www.ncbi.nlm.nih.gov/assembly/GCF_000001635.20
   * - rn6
     - Rattus norvigicus, rat
     - https://www.ncbi.nlm.nih.gov/assembly/GCF_000001895.5


ER diagram
~~~~~~~~~~
// kroki::  ./diagrams/cage-seq.puml png
//   :caption: Database schema for CAGE-seq data


Table cage_peaks_xx
~~~~~~~~~~~~~~~~~~~
These tables describes CAGE peaks (TSSs - Transcription Start Sites).

.. list-table::
   :header-rows: 1
   :widths: 25, 20, 10, 55

   * - Field
     - Type
     - Index
     - Description
   * - id
     - int(10)
     - primary
     - internal CAGE peak (TSS) identifier
   * - chrom
     - varchar(10)
     - +
     - chromosome according to coresponding genome build (xx) 
       Example: chr1. 
   * - start
     - int(10)
     - +
     - start of CAGE peak region
   * - end
     - int(10)
     - +
     - end of CAGE peak region
   * - strand
     - char(1)
     - 
     - TSS strand (+ or -)
   * - abs_summit
     - int(10)
     - 
     - start of the representative TSS position
   * - name
     - mediumtext ``-> varchar``
     - ?
     - name (ID) of the CAGE peak
       Example: hg19::chr1:564571..564600,+;hg_1.1
   * - type
     - varchar(255)
     - ?
     - type of CAGE peak: promoter or enhancer
   * - organism
     - varchar(50)
     -
     - organism. ``? remove``
   * - gene_symbol
     - mediumtext ``-> varchar``
     - +
     - gene symbol for CAGE peaks that are promoters 
   * - enhancer_id
     - int(10)
     - +
     - id of enhancer that includes this CAGE peak
   * - fantom5_id
     - mediumtext ``-> varchar``
     - +
     - CAGE peak id in FANTOM 5
   * - version
     - int(10)
     -
     - CAGE peak version
   * - source
     - varchar(255)
     - ?
     - Source (database or project) from which this CAGE peak was imported.
       Possible values: FANTOM 5

Table cage_promoters_annotation_xx
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Some CAGE peaks are annotated as promoters. Corresponding links are stored in cage_promoters_annotation_xx tables.

.. list-table::
   :header-rows: 1
   :widths: 25, 20, 10, 55

   * - Field
     - Type
     - Index
     - Description
   * - peak_id
     - int(10)
     - +
     - internal CAGE peak (TSS) identifier
   * - external_db
     - varchar(30)
     - 
     - External database name
   * - external_db_id
     - mediumtext ``-> varchar``
     - +
     - Corresponding transript/gene/protein identifier in the external database


Table cage_promoters2transcripts_xx
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Some CAGE peaks are annotated as promoters. Tables cage_promoters2transcripts contain distance and id for nearest transcripts (distance <500 bp).

.. list-table::
   :header-rows: 1
   :widths: 25, 20, 10, 55

   * - Field
     - Type
     - Index
     - Description
   * - peak_id
     - int(10)
     - mul
     - internal CAGE peak (TSS) identifier
   * - ensembl_transcript_id
     - varchar(30)
     - +
     - 
   * - distance
     - int(11)
     - 
     - 

Table cage_enhancers_xx
~~~~~~~~~~~~~~~~~~~~~~~
Some CAGE peaks are joined into enhancers. 

.. list-table::
   :header-rows: 1
   :widths: 25, 20, 10, 55

   * - Field
     - Type
     - Index
     - Description
   * - id
     - int(10)
     - primary
     - internal enhancer identifier
   * - chrom
     - varchar(10)
     - +
     - chromosome according to coresponding genome build (xx) 
       Example: chr1. 
   * - start
     - int(10)
     - +
     - start of enhancer region
   * - end
     - int(10)
     - +
     - end of enhancer region
   * - type
     - varchar(255)
     - 
     - Source (database or project) from which this enhancer was imported.
       Possible values: FANTOM 5
       ``rename to sourse``
   * - name
     - mediumtext ``-> varchar``
     - +
     - name (ID) of the CAGE peak
       Example: chr10:100006233-100006603

Table cage_enhancers2genes_xx
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
These tables describe what genes are potentially regulated by enhancers. 

.. list-table::
   :header-rows: 1
   :widths: 25, 20, 10, 55

   * - Field
     - Type
     - Index
     - Description
   * - enhancer_id
     - int(10)
     - +
     - internal enhancer identifier
   * - ensembl_gene_id
     - varchar(20)
     - +
     - 
   * - type
     - enum('corr','prox')
     - 
     - type of possible promoter-enhancer interaction
   * - distance
     - int(11)
     -
     - distance between promoter-enhancer, for type 'prox'
   * - corr
     - float
     -
     - expression correlation between promoter-enhancer, for type 'corr'
   * - padj
     - float
     -
     - adjusted P value for expression correlation between promoter-enhancer, for type 'corr'
