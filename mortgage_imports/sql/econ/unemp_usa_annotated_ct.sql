CREATE TABLE econ.unemp_usa_annotated
(
    dt                     Date,
    prop_cntry             LowCardinality(FixedString(5)),
    unemp_rate             Float32,
    unemp_rate_chg         Float32
)
ENGINE = MergeTree()
ORDER BY (dt, prop_cntry)
