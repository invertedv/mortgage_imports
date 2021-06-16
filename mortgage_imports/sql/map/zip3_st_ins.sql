/* creates a table that maps zip3 -> state.  Freddie/Fannie data has errors */

INSERT INTO map.zip3_st
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
    GROUP BY prop_zip3)
