CREATE TABLE aux.fctimes
(
    prop_st LowCardinality(FixedString(2)),
    prop_state LowCardinality(String),
    fc_type LowCardinality(String),
    fc_days Float32
)
ENGINE = MergeTree()
ORDER BY (prop_st)
