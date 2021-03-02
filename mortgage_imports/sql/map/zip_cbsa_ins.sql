
INSERT INTO map.zip_cbsa
SELECT
  prop_zip,
  groupArray(prop_cbsa_cd = '99999' ? '00000' : prop_cbsa_cd) AS cbsas,
  groupArray(res_ratio) AS res_ratio
FROM (
  SELECT
    prop_zip,
    prop_cbsa_cd,
    res_ratio
  FROM
    map.zip_cbsa_raw
  ORDER BY prop_zip, res_ratio DESC)
GROUP BY prop_zip

