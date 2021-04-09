INSERT INTO fannie.with_hpi
SELECT
  a.*,
  c.fhfa_zip3,
  b.fhfa_zip3,
  d.rt_mort15yr,
  d.rt_mort30yr,
  d.rt_mortarm5,
  d.rt_treas10yr,
  d.rt_libor12mo,
  d.rt_libor1mo,
  d.rt_libor3mo,
  f.rt_mort15yr,
  f.rt_mort30yr,
  f.rt_mortarm5,
  f.rt_treas10yr,
  f.rt_libor12mo,
  f.rt_libor1mo,
  f.rt_libor3mo,
  e.unemp_rate
FROM
  fannie.trans AS a
LEFT JOIN
  fhfa.zip3 AS b
ON
  a.prop_zip3 = b.prop_zip3
  AND toYear(a.dt) = b.yr
  AND toQuarter(a.dt) = b.qtr
LEFT JOIN
  fhfa.zip3 AS c
ON
  a.prop_zip3 = c.prop_zip3
  AND toYear(a.ln_orig_dt) = c.yr
  AND toQuarter(a.ln_orig_dt) = c.qtr
LEFT JOIN
  rates.monthly AS d
ON
  d.dt = a.dt
LEFT JOIN (
  SELECT
    dt,
    id,
    unemp_rate
  FROM ((
    SELECT
      dt,
      prop_msa_cd AS id,
      unemp_rate
    FROM
      econ.unemp_msa)
    UNION ALL (
      SELECT
        dt,
        cast(prop_st AS FixedString(5)) AS id,
        unemp_rate
      FROM
        econ.unemp_state))) AS e
ON
  e.dt = a.dt
  AND e.id = IF(a.prop_msa_cd='00000', cast(a.prop_st AS FixedString(5)), prop_msa_cd)
LEFT JOIN
  rates.monthly AS f
ON
  f.dt = toStartOfMonth(ln_orig_dt);
  


