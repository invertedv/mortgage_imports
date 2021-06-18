CREATE TABLE fhfa.usa_annotated
(
    prop_cntry                LowCardinality(FixedString(3)),
    dt                        Date,
    hpi                       Float32,
    hpi_qpct_chg              Float32
)
ENGINE = MergeTree()
ORDER BY (dt)


