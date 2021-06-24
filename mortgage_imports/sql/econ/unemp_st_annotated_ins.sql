INSERT INTO econ.unemp_state_annotated
    SELECT
        a.dt AS dt,
        a.prop_st_cd AS prop_st_cd,
        a.prop_st AS prop_st,
        a.unemp_rate AS unemp_rate,
        b.prop_state_name
    FROM
        econ.unemp_state AS a
    JOIN
        map.st_cd AS b
    ON
        a.prop_st = b.prop_st

