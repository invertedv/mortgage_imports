
INSERT INTO map.zip_cbsad
    SELECT
        prop_zip,
        groupArray(m) AS cbsads,
        groupArray(cbsatype) AS cbsa_type,
        groupArray(r) AS res_ratio
    FROM (
        SELECT
            c.prop_zip,
            c.m,
        /* if it is in an msa but it is not in the fhfa.msad_map table then
           it must be a micro
        */
            s = 'msa' and d.prop_msad_cd = '' ? 'micro' : s AS cbsatype,
            c.r
        FROM (
    /*
      map.zip_msa_raw has all zip codes
      map.zip_msad_raw has only zip codes in divisions
      msa code 99999 means not in a CBSA (metro or micro)
    */
            SELECT
                prop_zip,
                cast(multiIf(prop_cbsad_cd != '', prop_cbsad_cd,
                    prop_cbsa_cd = '99999', '00000', prop_cbsa_cd)
                    AS FixedString(5)) AS m,
                multiIf(prop_cbsad_cd != '', 'msad',
                  prop_cbsa_cd = '99999', 'none', 'msa') AS s,
                prop_cbsad_cd != '' ? a.res_ratio : b.res_ratio AS r
            FROM
                map.zip_cbsa_raw AS b
            LEFT JOIN
                map.zip_cbsad_raw AS a
            ON
                a.prop_zip = b.prop_zip) AS c
        LEFT JOIN
            fhfa.msad_map AS d
        ON
            c.m = d.prop_msad_cd
        ORDER BY prop_zip, r DESC)
    GROUP BY
        prop_zip
