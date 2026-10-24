CREATE TABLE files_info_stats
(
  species VARCHAR(50),
  exp_design VARCHAR(100),
  data_type VARCHAR(100),
  peakcaller VARCHAR(100),
  num INT DEFAULT 0
)DEFAULT CHARSET=utf8;

INSERT INTO files_info_stats 
    SELECT
        f.species AS "Species",
        f.exp_design AS "Experiment type",
        f.data_type AS "Data type",
        f.peakcaller AS "Peak caller", 
        count(*) AS "num"
        FROM files_info f
        GROUP BY 1, 2, 3, 4