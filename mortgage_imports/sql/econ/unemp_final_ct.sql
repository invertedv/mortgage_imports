CREATE TABLE econ.unemp_state
(
    dt                   Date,
    prop_st_cd           LowCardinality(FixedString(2)),
    prop_st              LowCardinality(FixedString(2)),
    unemp_rate           Float32
)    
ENGINE = MergeTree()
ORDER BY (dt, prop_st)
