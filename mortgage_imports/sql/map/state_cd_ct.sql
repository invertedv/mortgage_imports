CREATE TABLE map.st_cd
(
    prop_state_name                     LowCardinality(String),
    prop_st                             LowCardinality(FixedString(2)),
    prop_st_cd                          LowCardinality(FixedString(2))
)    
ENGINE = MergeTree()
ORDER BY (prop_st)
