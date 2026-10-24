

<#-- TODO  -->
<#-- Hyperlinks to different databases -->

<#macro linkAnimalDB  link_id, type>IF(${link_id} != '' AND ${link_id} != '-' AND ${type}='TF', '<a href="http://bioinfo.life.hust.edu.cn/AnimalTFDB2/search/entrez/' || ${link_id} || '.shtml" target="_blank">' || ${link_id} || '</a>', ${link_id}) </#macro>
<#macro linkCisBP     link_id> IF(${link_id} != '' AND ${link_id} != 'unmatched', '<a href="http://cisbp.ccbr.utoronto.ca/TFreport.php?searchTF=' || ${link_id} || '" target="_blank">' || ${link_id} || '</a>', ${link_id}) </#macro>
<#macro linkTFClass   link_id> IF(${link_id} != '', '<a href="http://genexplain.com/tfclass/huTF_classification_Genera.html" target="_blank">' || ${link_id} || '</a>', ${link_id}) </#macro>
<#macro linkUniprot   link_id> IF(${link_id} != '', '<a href="https://www.uniprot.org/uniprot/' || ${link_id} || '" target="_blank">' || ${link_id} || '</a>', ${link_id}) </#macro>
<#macro linkGeneCards link_id> IF(${link_id} != '', '<a href="https://www.genecards.org/cgi-bin/carddisp.pl?gene=' || ${link_id} || '" target="_blank">' || ${link_id} || '</a>', ${link_id}) </#macro>

<#macro linkGEO link_id>
CONCAT('<a href="http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=', ${link_id}, '" target="_blank">', ${link_id}, '</a>') </#macro>

<#assign control = "('control', 'bio-control', 'chip_control', 'chipexo_control', 'hist_control')">

<#assign chromatin = "('DNase-seq', 'ATAC-seq', 'MNase-eq', 'FAIRE-seq')">

<#assign search_tf = "
 <if parameter=\"tf\">
    AND ( u.cached_tf_class LIKE '<parameter:tf/>%' OR e.antibody LIKE '<parameter:tf/>%'
          OR u.id= '<parameter:tf/>' OR u.gene_name='<parameter:tf/>%' OR u.protein_names LIKE '%<parameter:tf/>%' )  
 </if>"
>

<#assign search_geo = "
 <if parameter=\"geo\">
    AND ( e.geo_gse ='<parameter:geo/>' OR e.geo_gsm = '<parameter:geo/>' ) 
 </if>"
>
