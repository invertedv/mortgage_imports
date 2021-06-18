/* creates a table that maps zip3 -> state.  Freddie/Fannie data has errors */

INSERT INTO map.zip3_st
    SELECT
        a.prop_zip3 AS prop_zip3,
        a.prop_st AS prop_st,
        a.cnt AS cnt,
        b.prop_zip AS prop_zip
    FROM (
        SELECT
            prop_zip3,
            arrayElement(ps, 1) AS prop_st,
            arrayElement(ns, 1) AS cnt
        FROM(
            SELECT
              prop_zip3,
              groupArray(prop_st) AS ps,
              groupArray(n) AS ns
            FROM (
                SELECT
                    prop_zip3,
                    prop_st,
                    count(*) AS n
                FROM
                    unified.frannie
                GROUP BY
                    prop_zip3,
                    prop_st
                ORDER BY n DESC)
            GROUP BY prop_zip3)) AS a
        JOIN (
            SELECT
                prop_zip3,
                arrayElement(pz, 1) AS prop_zip
            FROM (
                SELECT
                    prop_zip3,
                    groupArray(prop_zip) AS pz,
                    groupArray(res_ratio) AS rr
                FROM (
                    SELECT
                        substr(prop_zip, 1, 3) AS prop_zip3,
                        prop_zip,
                    arrayElement(ctys.res_ratio, 1) AS res_ratio
                FROM
                    map.zip_cty
                ORDER BY prop_zip3, res_ratio DESC)
                GROUP BY prop_zip3)) AS b
        ON
            a.prop_zip3 = b.prop_zip3