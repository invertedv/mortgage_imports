/*
 based on CBSA's. so has more than just MSAs.  The names are from MSAD, so will be missing the name
 when the MSA is split into divisions

 */
CREATE TABLE map.msa_geos
(
    prop_msa_cd                        LowCardinality(FixedString(5)),
    prop_msa_nm                        LowCardinality(String),
    geos Nested (
        prop_zip                        LowCardinality(FixedString(5)),
        prop_city                       LowCardinality(String),
        prop_st                         LowCardinality(FixedString(2)),
        res_ratio                       Float32
    )
)
ENGINE = MergeTree()
ORDER BY (prop_msa_cd)
