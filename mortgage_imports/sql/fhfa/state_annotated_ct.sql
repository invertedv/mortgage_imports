CREATE TABLE fhfa.state_annotated
(
    prop_st                   LowCardinality(FixedString(2)),
    dt                        Date,
    hpi                       Float32,
    hpi_qpct_chg              Float32
)
ENGINE = MergeTree()
ORDER BY (prop_st, dt)


