CREATE TABLE fhfa.state_non_msa_annotated
(
    prop_st                   LowCardinality(FixedString(2)),
    prop_state_name           LowCardinality(String),
    dt                        Date,
    hpi                       Float32,
    hpi_qpct_chg              Float32
)
ENGINE = MergeTree()
ORDER BY (prop_st, dt)


