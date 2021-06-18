CREATE TABLE fhfa.zip3_annotated
(
    prop_zip3                  LowCardinality(FixedString(3)),
    prop_st                    LowCardinality(FixedString(2)),
    dt                         Date,
    hpi                        Float32,
    hpi_qpct_chg               Float32
)
ENGINE = MergeTree()
ORDER BY (prop_zip3, dt);


