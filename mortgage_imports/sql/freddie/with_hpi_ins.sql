INSERT INTO freddie.with_hpi
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
  ue1.unemp_rate = 0 ? ue2.unemp_rate : ue1.unemp_rate
FROM
  freddie.trans AS a
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
  AND toYear(date_sub(month, 1, a.ln_fp_dt)) = c.yr
  AND toQuarter(date_sub(month, 1, a.ln_fp_dt)) = c.qtr
LEFT JOIN
  rates.monthly AS d
ON
  d.dt = a.dt
LEFT JOIN
  econ.unemp_msa as ue1
ON
  ue1.dt = a.dt
  AND a.prop_msa_cd = ue1.prop_msa_cd
LEFT JOIN
  econ.unemp_state as ue2
ON
  ue2.dt = a.dt
  AND a.prop_st = ue2.prop_st
LEFT JOIN
  rates.monthly AS f
ON
  f.dt = toStartOfMonth(date_sub(month, 1, a.ln_fp_dt));



