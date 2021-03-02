INSERT INTO rates.monthly 
SELECT
  a.dt,
  a.rt_mort15yr IS NULL ? -99.0 : rt_mort15yr,
  a.rt_mort30yr IS NULL ? -99.0 : rt_mort30yr,
  a.rt_mortarm5 IS NULL ? -99.0 : rt_mortarm5,


  b.rt_treas10yr IS NULL ? -99.0 : b.rt_treas10yr,
  b.rt_libor12mo IS NULL ? -99.0 : b.rt_libor12mo,
  b.rt_libor1mo IS NULL ? -99.0 : b.rt_libor1mo,
  b.rt_libor3mo IS NULL ? -99.0 : b.rt_libor3mo

FROM (
  SELECT
    toStartOfMonth(dt) AS dt,

    SUM(rt_mort15yr_wk) > 0 ?
      SUM(rt_mort15yr_wk) / SUM(rt_mort15yr_wk > 0 ? 1 : 0) : NULL AS rt_mort15yr,

    SUM(rt_mort30yr_wk) > 0 ?
      SUM(rt_mort30yr_wk) / SUM(rt_mort30yr_wk > 0 ? 1 : 0) : NULL AS rt_mort30yr,

    SUM(rt_mortarm5_wk) > 0 ?
      SUM(rt_mortarm5_wk) / SUM(rt_mortarm5_wk > 0 ? 1 : 0) : NULL AS rt_mortarm5

  FROM
    rates.weekly_raw
  GROUP BY dt
  ORDER BY dt) AS a
JOIN (
  SELECT
    toStartOfMonth(dt) AS dt,

    SUM(rt_treas10yr_dly) > 0 ?
      SUM(rt_treas10yr_dly) / SUM(rt_treas10yr_dly > 0 ? 1 : 0) : NULL AS rt_treas10yr,

    SUM(rt_libor12mo_dly) > 0 ?
      SUM(rt_libor12mo_dly) / SUM(rt_libor12mo_dly > 0 ? 1 : 0) : NULL AS rt_libor12mo,

    SUM(rt_libor1mo_dly) > 0 ?
      SUM(rt_libor1mo_dly) / SUM(rt_libor1mo_dly > 0 ? 1 : 0) : NULL AS rt_libor1mo,

    SUM(rt_libor3mo_dly) > 0 ?
      SUM(rt_libor3mo_dly) / SUM(rt_libor3mo_dly > 0 ? 1 : 0) : NULL AS rt_libor3mo

  FROM
    rates.daily_raw
  GROUP BY dt
  ORDER BY dt) AS b
  ON a.dt = b.dt


