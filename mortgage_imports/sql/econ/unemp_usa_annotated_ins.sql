INSERT INTO econ.unemp_usa_annotated
    SELECT
        a.dt,
        a.prop_ctry_cd AS prop_cntry,
        a.unemp_rate,
        a.unemp_rate - b.unemp_rate AS unemp_rate_chg
    FROM
        econ.unemp_usa AS a
    JOIN
        econ.unemp_usa AS b
    ON
        subtractMonths(a.dt, 1) = b.dt
        AND a.prop_ctry_cd = b.prop_ctry_cd
