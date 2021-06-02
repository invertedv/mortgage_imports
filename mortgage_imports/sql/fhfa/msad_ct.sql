CREATE TABLE fhfa.msad
(
    prop_msad_nm                     LowCardinality(String),
    prop_msad_cd                     LowCardinality(FixedString(5)),
    yr                               UInt16,
    qtr                              UInt8,
    fhfa_msad                        Nullable(Float32),
    delta                            Nullable(Float32)
    )
ENGINE = MergeTree()
ORDER BY (prop_msad_cd, yr, qtr);
    

