INSERT INTO fhfa.zip3_annotated
    SELECT
        a.prop_zip3 AS prop_zip3,
        c.prop_st,
        a.dt AS dt,
        a.hpi AS hpi,
        100 * (a.hpi / b.hpi - 1.0) AS hpi_qpct_chg
    FROM (
        SELECT
            prop_zip3,
            fhfa_zip3 AS hpi,
            toDate(concat(toString(yr), '-', toString(3 * qtr), '-01')) AS dt
        FROM
            fhfa.zip3) AS a
    JOIN (
        SELECT
            prop_zip3,
            fhfa_zip3 AS hpi,
            toDate(concat(toString(yr), '-', toString(3 * qtr), '-01')) AS dt
        FROM
            fhfa.zip3) AS b
    ON
        subtractQuarters(a.dt, 1) = b.dt
        AND a.prop_zip3 = b.prop_zip3
    JOIN
        map.zip3_st AS c
    ON
        c.prop_zip3 = a.prop_zip3
