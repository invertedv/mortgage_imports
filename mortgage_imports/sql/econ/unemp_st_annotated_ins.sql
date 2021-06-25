INSERT INTO econ.unemp_state_annotated
    SELECT
        a.dt AS dt,
        a.prop_st_cd AS prop_st_cd,
        a.prop_st AS prop_st,
        a.unemp_rate AS unemp_rate,
        a.unemp_rate_chg AS unemp_rate_chg,
        b.prop_state_name
    FROM (
        SELECT
            x.dt AS dt,
            x.prop_st_cd AS prop_st_cd,
            x.prop_st AS prop_st,
            x.unemp_rate AS unemp_rate,
            x.unemp_rate - y.unemp_rate AS unemp_rate_chg
        FROM
            econ.unemp_state AS x
        JOIN
            econ.unemp_state AS y
        ON
            subtractMonths(x.dt, 1) = y.dt
            AND x.prop_st = y.prop_st) AS a
    JOIN
        map.st_cd AS b
    ON
        a.prop_st = b.prop_st

