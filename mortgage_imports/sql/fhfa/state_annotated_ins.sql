INSERT INTO fhfa.state_annotated
    SELECT
        a.prop_st AS prop_st,
        a.dt AS dt,
        a.hpi AS hpi,
        100.0 * (a.hpi / b.hpi - 1) AS hpi_qpct_chg
    FROM (
        SELECT
            prop_st,
            toDate(concat(toString(yr), '-', toString(3 * qtr), '-01')) AS dt,
            fhfa_st AS hpi
        FROM
            fhfa.state
        WHERE
            hpi IS NOT NULL) AS a
    JOIN (
        SELECT
            prop_st,
            toDate(concat(toString(yr), '-', toString(3 * qtr), '-01')) AS dt,
            fhfa_st AS hpi
        FROM
            fhfa.state
        WHERE
            hpi IS NOT NULL) AS b
    ON
        subtractQuarters(a.dt, 1) = b.dt
        AND a.prop_st = b.prop_st
