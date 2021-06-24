INSERT INTO fhfa.msad_annotated
    SELECT
        a.prop_msad_nm AS prop_msad_nm,
        a.prop_msad_cd AS prop_msad_cd,
        a.dt AS dt,
        a.hpi AS hpi,
        100.0 * (a.hpi / b.hpi - 1.0) AS hpi_qpct_chg,
        c.prop_st,
        c.prop_city,
        c.prop_nzips
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
    JOIN (
        SELECT
            prop_msad_cd,
            prop_msad_nm,
            arrayElement(groupArray(prop_st), 1) AS prop_st,
            arrayElement(groupArray(prop_city), 1) AS prop_city,
            arrayElement(groupArray(nzips), 1) AS prop_nzips
        FROM (
            SELECT
                prop_msad_cd,
                prop_msad_nm,
                g.prop_st AS prop_st,
                g.prop_city AS prop_city,
                COUNT(*) AS nzips
            FROM
                map.msad_geos ARRAY JOIN geos AS g
            WHERE
                g.res_ratio > 0.5
            GROUP BY prop_msad_cd, prop_msad_nm, prop_st, prop_city
            ORDER BY prop_msad_cd, nzips DESC)
        GROUP BY prop_msad_cd, prop_msad_nm) AS c
    ON
        a.prop_msad_cd = c.prop_msad_cd
