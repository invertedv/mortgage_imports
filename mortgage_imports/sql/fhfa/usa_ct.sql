CREATE TABLE fhfa.usa
(
    prop_cntry                LowCardinality(FixedString(3)),
    yr                        UInt16,
    qtr                       UInt8,
    fhfa_usa                  Float32
)
ENGINE = MergeTree()
ORDER BY (yr, qtr);


