INSERT INTO
  fhfa.msad_map
SELECT
    prop_msad_cd,
    prop_msad_nm
FROM
  fhfa.msad
GROUP BY prop_msad_cd, prop_msad_nm;
