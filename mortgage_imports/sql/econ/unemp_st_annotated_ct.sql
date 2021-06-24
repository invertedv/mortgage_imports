CREATE TABLE econ.unemp_state_annotated
(
    dt                   Date,
    prop_st_cd           LowCardinality(FixedString(2)),
    prop_st              LowCardinality(FixedString(2)),
    unemp_rate           Float32,
    prop_state_name      LowCardinality(String)
)
ENGINE = MergeTree()
ORDER BY (prop_st, dt)
