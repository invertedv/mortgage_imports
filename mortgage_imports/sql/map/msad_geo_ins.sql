INSERT INTO map.msad_geos
    SELECT
        a.prop_msad_cd,
        a.prop_msad_nm,
        b.prop_zip,
        b.prop_city,
        b.prop_st,
        b.res_ratio
    FROM (
        SELECT
            prop_msad_cd,
            prop_msad_nm
        FROM
            fhfa.msad
        GROUP BY
            prop_msad_cd,
            prop_msad_nm) AS a
    JOIN (
            SELECT
                prop_msad_cd,
                groupArray(prop_zip) AS prop_zip,
                groupArray(prop_st) AS prop_st,
                groupArray(prop_city) AS prop_city,
                groupArray(res_ratio) AS res_ratio
            FROM (
                SELECT
                    c.prop_cbsad_cd AS prop_msad_cd,
                    c.res_ratio AS res_ratio,
                    prop_zip,
                    c.prop_city AS prop_city,
                    c.prop_st AS prop_st
                FROM
                    map.zip_cbsad ARRAY JOIN cbsads AS c
                ORDER BY prop_msad_cd, res_ratio DESC)
            GROUP BY prop_msad_cd) AS b
    ON
        a.prop_msad_cd = b.prop_msad_cd