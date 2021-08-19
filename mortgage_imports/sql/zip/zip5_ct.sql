/*
zip code data.  The main interest here is latitude/longitude
*/

CREATE TABLE zip.zip5
(
    prop_cntry                         LowCardinality(String),
    prop_zip                           LowCardinality(FixedString(5)),
    prop_city                          String,
    prop_st_nm                         LowCardinality(String),
    prop_st                            LowCardinality(FixedString(2)),
    prop_descr                         LowCardinality(String),
    fill1                              LowCardinality(String),
    fill2                              LowCardinality(String),
    fill3                              LowCardinality(String),
    latitude                           Float32,
    longitude                          Float32,
    fill4                              LowCardinality(String)
)
ENGINE = MergeTree()
ORDER BY (prop_zip)
