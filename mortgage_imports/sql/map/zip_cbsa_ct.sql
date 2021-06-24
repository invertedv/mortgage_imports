CREATE TABLE map.zip_cbsa
(
    prop_zip                  LowCardinality(FixedString(5)),
    cbsas Nested(
        prop_cbsa_cd          LowCardinality(FixedString(5)),
        prop_city             LowCardinality(String),
        prop_st               LowCardinality(FixedString(2)),
        res_ratio             Float32)
)
ENGINE = MergeTree()
ORDER BY (prop_zip)
