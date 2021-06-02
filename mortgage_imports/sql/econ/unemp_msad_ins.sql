INSERT INTO econ.unemp_msad
      SELECT
          dt,
          prop_msad_cd,
          unemp_rate
      FROM ((
          SELECT
              dt,
              prop_msad_cd,
              unemp_rate
          FROM
              econ.unemp_msad0)
      UNION ALL (
          SELECT
              a.dt,
              a.prop_msa_cd AS prop_msad_cd,
              a.unemp_rate
          FROM
              econ.unemp_msa AS a
          JOIN (
              SELECT
                  distinct cbsads.prop_cbsad_cd AS prop_msad_cd
              FROM
                  map.zip_cbsad ARRAY JOIN cbsads) AS b
          ON a.prop_msa_cd = b.prop_msad_cd))
