<#assign SOURCE="gtrd_v1903">
<#assign TARGET="gtrd_current">

DROP TABLE IF EXISTS ${TARGET}.data_types;
CREATE TABLE ${TARGET}.data_types
(
  id VARCHAR(50) NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT NOT NULL,
  order_ INT NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


<#macro dataType order, type, name, description>
INSERT INTO ${TARGET}.data_types values(${type?str}, ${name?str}, ${description?str}, ${order});
</#macro>


<@dataType  1, "Meta-clusters",                          "meta-clusters",
"Non-redundant set of TF binding sites. For a given TF corresponding binding sites were merged by all experiments and peak callers.
Each cluster is confirmed at least by 2 binding sites." />

<@dataType  2, "Meta-clusters_by_TF",                    "meta-clusters by TF",
"Non-redundant set of TF binding sites for a given TF. Corresponding binding sites were merged by all experiments and peak callers.
Each cluster is confirmed at least by 2 binding sites." />

<@dataType  3, "Meta-clusters_by_TF_and_Cell_Type",      "meta-clusters by TF and cell type",
"Non-redundant set of TF binding sites for a given TF in the specified cell line. Corresponding binding sites were merged by all experiments and peak callers.
Each cluster is confirmed at least by 2 binding sites." />

<@dataType  4, "Clusters_by_TF",                         "clusters by TF",
"Non-redundant set of TF binding sites for a given TF. Corresponding binding sites were merged by 4 peak callers.
Each cluster is confirmed at least by 2 binding sites." />



<@dataType  5, "Clusters_by_Cell_Type",                  "clusters of open chromatin regions",   "" />
<@dataType  6, "Footprint_Clusters_by_Cell_Type",        "clusters of footprint regions",        "" />
<@dataType  7, "Footprints",                             "footprint regions",                    "" />


<@dataType  8, "Clusters_by_Target_and_Cell_Type",       "clusters of histone marks",            "" />

<@dataType  9, "Peaks",                                  "peaks",                                "" />

<@dataType 10, "ASB_by_TF",          "Allele specific binding sites by TF",                      "" />
<@dataType 11, "ASB_by_Cell_Type",   "Allele specific TF binding sites by cell types",           "" />

<@dataType 12, "Alignment",                              "Alignment or alignment profile",       "" />


UPDATE ${TARGET}.files_info SET exp_design = '-' WHERE exp_design IS NULL;

DROP TABLE IF EXISTS ${TARGET}.experiment2data_types;
CREATE TABLE ${TARGET}.experiment2data_types
(
  species VARCHAR(50),
  experiment_type VARCHAR(20),
  data_type VARCHAR(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO ${TARGET}.experiment2data_types(species, experiment_type, data_type) 
SELECT f.species, f.exp_design, f.data_type FROM ${TARGET}.files_info f
GROUP BY 1,2,3;


DROP TABLE IF EXISTS ${TARGET}.files_info_stats;
CREATE TABLE ${TARGET}.files_info_stats
(
  species VARCHAR(50),
  exp_design VARCHAR(100),
  data_type VARCHAR(100),
  peakcaller VARCHAR(100),
  num INT DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO ${TARGET}.files_info_stats 
    SELECT
        f.species AS "Species",
        f.exp_design AS "Experiment type",
        f.data_type AS "Data type",
        f.peakcaller AS "Peak caller", 
        count(*) AS "num"
        FROM ${INFO_SCHEMA}.files_info f
        GROUP BY 1, 2, 3, 4