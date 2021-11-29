CREATE TABLE unified.slr_map
(
    slr_name                 LowCardinality(String),
    slr_mapped               LowCardinality(String),
    pp_group                 LowCardinality(FixedString(6)),
    pp_rate                  Float32,
    nloans                   Int16
)
ENGINE = MergeTree()
ORDER BY (slr_name);
