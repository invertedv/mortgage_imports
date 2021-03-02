CREATE TABLE map.zip_cbsa_raw
(
    prop_zip LowCardinality(FixedString(5)),
    prop_cbsa_cd LowCardinality(FixedString(5)),
    res_ratio Float32,
    bus_ratio Float32,
    oth_ratio Float32,
    tot_ratio Float32)
ENGINE = MergeTree()
ORDER BY (prop_zip)
