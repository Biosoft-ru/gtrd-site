DELETE FROM species;

INSERT INTO species

CREATE TABLE species 
SELECT species, 
CASE 
 WHEN species='Arabidopsis thaliana' THEN 'at'
 WHEN species='Caenorhabditis elegans' THEN 'ce'
 WHEN species='Danio rerio' THEN 'dr'
 WHEN species='Drosophila melanogaster' THEN 'dm'
 WHEN species='Homo sapiens' THEN 'hs'
 WHEN species='Mus musculus' THEN 'mm'
 WHEN species='Rattus norvegicus' THEN 'rn'
 WHEN species='Saccharomyces cerevisiae' THEN 'sc'
 WHEN species='Schizosaccharomyces pombe' THEN 'sp' 
END AS "short_name"
FROM cells GROUP BY species ORDER BY species;
