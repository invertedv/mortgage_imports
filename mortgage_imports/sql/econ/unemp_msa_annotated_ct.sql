CREATE TABLE econ.unemp_msa_annotated
(
    dt                     Date,
    prop_msa_cd            LowCardinality(FixedString(5)),
    unemp_rate             Float32,
    unemp_rate_chg         Float32,
    prop_msa_nm            LowCardinality(String),
    prop_st                LowCardinality(FixedString(2)),
    prop_city              LowCardinality(String),
    prop_nzips             Int8
)
ENGINE = MergeTree()
ORDER BY (prop_msa_cd, dt)
