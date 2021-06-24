INSERT INTO econ.XXXX
    SELECT
        toDate(concat(yr_str, '-', substr(mo_str, 2, 2), '-', '01')) AS dt,
        'USA' AS prop_cntry,
        value AS unemp_rate
    FROM
        econ.XXXX_raw
