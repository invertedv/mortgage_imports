INSERT INTO econ.unemp_msad_annotated
    SELECT
        a.dt,
        a.prop_msad_cd,
        a.unemp_rate,
        a.unemp_rate_chg,
        b.prop_msad_nm,
        b.prop_st,
        concat(substring(prop_city, 1, 1), lower(substring(prop_city, 2))) AS prop_city,
        b.prop_nzips
    FROM (
        SELECT
            x.dt,
            x.prop_msad_cd,
            x.unemp_rate,
            x.unemp_rate - y.unemp_rate AS unemp_rate_chg
        FROM
            econ.unemp_msad AS x
        JOIN
            econ.unemp_msad AS y
        ON
            subtractMonths(x.dt, 1) = y.dt
            AND x.prop_msad_cd = y.prop_msad_cd) AS a
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
        GROUP BY prop_msad_cd, prop_msad_nm) AS b
    ON
        a.prop_msad_cd = b.prop_msad_cd