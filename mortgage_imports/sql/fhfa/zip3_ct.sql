CREATE TABLE fhfa.zip3
(
    prop_zip3 LowCardinality(FixedString(3)),
    yr UInt16,
    qtr UInt8,
    fhfa_zip3 Float32,
    index_type LowCardinality(String))
ENGINE = MergeTree()
ORDER BY (prop_zip3, yr, qtr);
    

