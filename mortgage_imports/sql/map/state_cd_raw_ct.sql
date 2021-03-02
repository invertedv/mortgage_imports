CREATE TABLE map.st_cd_raw
(
    prop_state_name LowCardinality(String),
    prop_st LowCardinality(String),
    prop_st_cd  LowCardinality(String)
)    
ENGINE = MergeTree()
ORDER BY (prop_st)
