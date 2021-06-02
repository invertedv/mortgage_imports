INSERT INTO econ.XXXXX
    SELECT
        cast(concat(yr_str, '-', substr(mo_str, 2, 2), '-', '01') AS Date) AS dt,
        YYYYY,
        toFloat32OrNull(trim(value)) IS NULL ? -99.0 : toFloat32OrNull(trim(value))
    FROM
        econ.XXXXX_raw
    WHERE
        substr(id, 20, 1) = '3'
      /* there are two msas with both U and S here */
        ZZZZ

