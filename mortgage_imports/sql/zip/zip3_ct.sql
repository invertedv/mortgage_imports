/*
zip code data @ zip3 level
*/

CREATE TABLE zip.zip3
(
    prop_zip3                          LowCardinality(FixedString(3)),
    prop_city                          LowCardinality(String),
    latitude                           Float32,
    longitude                          Float32
)
ENGINE = MergeTree()
ORDER BY (prop_zip3)
