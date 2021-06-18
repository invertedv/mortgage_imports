INSERT INTO fhfa.msad_annotated
    SELECT
        a.prop_msad_nm AS prop_msad_nm,
        a.prop_msad_cd AS prop_msad_cd,
        a.dt AS dt,
        a.hpi AS hpi,
        100.0 * (a.hpi / b.hpi - 1.0) AS hpi_qpct_chg

    FROM (
        SELECT
            prop_msad_nm,
            prop_msad_cd,
            toDate(concat(toString(yr), '-', toString(3 * qtr), '-01')) AS dt,
            fhfa_msad AS hpi
        FROM
            fhfa.msad
        WHERE
            hpi IS NOT NULL) AS a
    JOIN (
        SELECT
            prop_msad_nm,
            prop_msad_cd,
            toDate(concat(toString(yr), '-', toString(3 * qtr), '-01')) AS dt,
            fhfa_msad AS hpi
        FROM
            fhfa.msad
        WHERE
            hpi IS NOT NULL) AS b
    ON
        subtractQuarters(a.dt, 1) = b.dt
        AND a.prop_msad_cd = b.prop_msad_cd
