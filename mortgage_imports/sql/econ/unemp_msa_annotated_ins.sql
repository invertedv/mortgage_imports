INSERT INTO econ.unemp_msa_annotated
    SELECT
        a.dt,
        a.prop_msa_cd,
        a.unemp_rate,
        a.unemp_rate_chg,
        if(b.prop_msa_nm = '', concat(substring(prop_city, 1, 1), lower(substring(prop_city, 2))), b.prop_msa_nm) AS prop_msa_nm,
        b.prop_st,
        concat(substring(prop_city, 1, 1), lower(substring(prop_city, 2))) AS prop_city,
        b.prop_nzips
    FROM (
        SELECT
            x.dt,
            x.prop_msa_cd,
            x.unemp_rate,
            x.unemp_rate - y.unemp_rate AS unemp_rate_chg
        FROM
            econ.unemp_msa AS x
        JOIN
            econ.unemp_msa AS y
        ON
            subtractMonths(x.dt, 1) = y.dt
            AND x.prop_msa_cd = y.prop_msa_cd) AS a
    JOIN (
        SELECT
            prop_msa_cd,
            prop_msa_nm,
            arrayElement(groupArray(prop_st), 1) AS prop_st,
            arrayElement(groupArray(prop_city), 1) AS prop_city,
            arrayElement(groupArray(nzips), 1) AS prop_nzips
        FROM (
            SELECT
                prop_msa_cd,
                prop_msa_nm,
                g.prop_st AS prop_st,
                g.prop_city AS prop_city,
                COUNT(*) AS nzips
            FROM
                map.msa_geos ARRAY JOIN geos AS g
            WHERE
                g.res_ratio > 0.5
            GROUP BY prop_msa_cd, prop_msa_nm, prop_st, prop_city
            ORDER BY prop_msa_cd, nzips DESC)
        GROUP BY prop_msa_cd, prop_msa_nm) AS b
    ON
        a.prop_msa_cd = b.prop_msa_cd