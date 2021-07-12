INSERT INTO map.msa_geos
    SELECT
        b.prop_msa_cd,
        a.prop_msa_nm,
        b.prop_zip,
        b.prop_city,
        b.prop_st,
        b.res_ratio
    FROM (
        SELECT
            prop_msad_cd AS prop_msa_cd,
            prop_msad_nm AS prop_msa_nm
        FROM
            fhfa.msad
        GROUP BY
            prop_msa_cd,
            prop_msa_nm) AS a
    RIGHT JOIN (
            SELECT
                prop_msa_cd,
                groupArray(prop_zip) AS prop_zip,
                groupArray(prop_st) AS prop_st,
                groupArray(prop_city) AS prop_city,
                groupArray(res_ratio) AS res_ratio
            FROM (
                SELECT
                    c.prop_cbsa_cd AS prop_msa_cd,
                    c.res_ratio AS res_ratio,
                    prop_zip,
                    c.prop_city AS prop_city,
                    c.prop_st AS prop_st
                FROM
                    map.zip_cbsa ARRAY JOIN cbsas AS c
                ORDER BY prop_msa_cd, res_ratio DESC)
            GROUP BY prop_msa_cd) AS b
    ON
        a.prop_msa_cd = b.prop_msa_cd