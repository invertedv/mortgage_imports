
INSERT INTO map.zip_cty
    SELECT
        prop_zip,
        groupArray(prop_cty_cd) AS msads,
        groupArray(res_ratio) AS res_ratio
    FROM (
        SELECT
            prop_zip,
            prop_cty_cd,
            res_ratio
        FROM
            map.zip_cty_raw
        ORDER BY
            prop_zip, res_ratio DESC)
GROUP BY
    prop_zip

