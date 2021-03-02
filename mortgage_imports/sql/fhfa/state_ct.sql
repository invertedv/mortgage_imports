CREATE TABLE fhfa.state
(
    prop_st LowCardinality(FixedString(2)),
    yr UInt16,
    qtr UInt8,
    fhfa_st Float32)
ENGINE = MergeTree()
ORDER BY (prop_st, yr, qtr);
    

