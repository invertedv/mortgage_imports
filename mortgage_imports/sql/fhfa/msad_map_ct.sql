CREATE TABLE fhfa.msad_map
(
    prop_msad_cd                LowCardinality(FixedString(5)),
    prop_msad_nm                LowCardinality(String)
    )
ENGINE = MergeTree()
ORDER BY (prop_msad_cd);
    

