INSERT INTO econ.XXXXX
  SELECT
    dt,
    YYYYY,
    unemp_rate
  FROM (
    SELECT
      dt,
      prop_micro_cd AS YYYYY,
      unemp_rate
    FROM
      econ.unemp_micro)
  UNION ALL (
    SELECT
      dt,
      ZZZZZ AS YYYYY,
      unemp_rate
    FROM
      TTTTT)
