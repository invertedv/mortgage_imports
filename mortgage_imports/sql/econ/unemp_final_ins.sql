INSERT INTO econ.unemp_state
    SELECT
        a.dt,
        a.prop_st_cd,
        b.prop_st,
        a.unemp_rate
    FROM
        econ.unemp_state0 AS a
    JOIN
        map.st_cd AS b
    ON
        a.prop_st_cd = b.prop_st_cd

  
