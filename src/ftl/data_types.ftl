DELETE FROM data_types;

<#macro dataType order, type, name, description>
INSERT INTO data_types values(${type?str}, ${name?str}, ${description?str}, ${order});
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



DELETE FROM experiment2data_types;
INSERT INTO experiment2data_types(species, experiment_type, data_type) 
SELECT f.species, f.exp_design, f.data_type FROM ${TARGET}.files_info f
GROUP BY 1,2,3;
