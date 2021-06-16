CREATE TABLE map.zip3_st
(
    prop_zip3                           LowCardinality(String),
    prop_st                             LowCardinality(FixedString(2)),
    cnt                                 UInt16
)
ENGINE = MergeTree()
ORDER BY (prop_zip3)
