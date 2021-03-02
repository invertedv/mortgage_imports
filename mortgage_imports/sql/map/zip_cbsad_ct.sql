CREATE TABLE map.zip_cbsad
(
    prop_zip LowCardinality(FixedString(5)),
    cbsads Nested(
      prop_cbsad_cd LowCardinality(FixedString(5)),
      cbsa_type LowCardinality(String),
      res_ratio Float32)
)
ENGINE = MergeTree()
ORDER BY (prop_zip)
