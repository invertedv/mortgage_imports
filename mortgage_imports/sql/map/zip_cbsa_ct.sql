CREATE TABLE map.zip_cbsa
(
    prop_zip LowCardinality(FixedString(5)),
    cbsas Nested(
      prop_cbsa_cd LowCardinality(FixedString(5)),
      res_ratio Float32)
)
ENGINE = MergeTree()
ORDER BY (prop_zip)
