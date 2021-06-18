CREATE TABLE fhfa.msad_annotated
(
    prop_msad_nm                     LowCardinality(String),
    prop_msad_cd                     LowCardinality(FixedString(5)),
    dt                               Date,
    hpi                              Nullable(Float32),
    hpi_qpct_chg                     Float32
    )
ENGINE = MergeTree()
ORDER BY (prop_msad_cd, dt)


