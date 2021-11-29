CREATE TABLE unified.serv_map
(
    serv_name                LowCardinality(String),
    serv_mapped              LowCardinality(String),
    pp_group                 LowCardinality(FixedString(6)),
    pp_rate                  Float32,
    nloans                   Int16
)
ENGINE = MergeTree()
ORDER BY (serv_name);
