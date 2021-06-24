CREATE TABLE map.msad_geos
(
    prop_msad_cd                        LowCardinality(FixedString(5)),
    prop_msad_nm                        LowCardinality(String),
    geos Nested (
        prop_zip                        LowCardinality(FixedString(5)),
        prop_city                       LowCardinality(String),
        prop_st                         LowCardinality(FixedString(2)),
        res_ratio                       Float32
    )
)
ENGINE = MergeTree()
ORDER BY (prop_msad_cd)
