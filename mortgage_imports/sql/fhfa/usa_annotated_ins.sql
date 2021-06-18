INSERT INTO fhfa.usa_annotated
    SELECT
        a.prop_cntry AS prop_cntry,
        a.dt AS dt,
        a.hpi AS hpi,
        100.0 * (a.hpi / b.hpi - 1) AS hpi_qpct_chg
    FROM (
        SELECT
            prop_cntry,
            toDate(concat(toString(yr), '-', toString(3 * qtr), '-01')) AS dt,
            fhfa_usa AS hpi
        FROM
            fhfa.usa
        WHERE
            hpi IS NOT NULL) AS a
    JOIN (
        SELECT
            toDate(concat(toString(yr), '-', toString(3 * qtr), '-01')) AS dt,
            fhfa_usa AS hpi
        FROM
            fhfa.usa
        WHERE
            hpi IS NOT NULL) AS b
    ON
        subtractQuarters(a.dt, 1) = b.dt
