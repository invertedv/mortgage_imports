CREATE TABLE fhfa.state_non_msa
(
    prop_st LowCardinality(FixedString(2)),
    yr UInt16,
    qtr UInt8,
    fhfa_st_non_msa Float32)
ENGINE = MergeTree()
ORDER BY (prop_st, yr, qtr);
    

