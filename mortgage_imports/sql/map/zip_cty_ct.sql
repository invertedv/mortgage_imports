CREATE TABLE map.zip_cty
(
    prop_zip LowCardinality(FixedString(5)),
    ctys Nested(
      prop_cty_cd LowCardinality(FixedString(5)),
      res_ratio Float32)
)
ENGINE = MergeTree()
ORDER BY (prop_zip)

