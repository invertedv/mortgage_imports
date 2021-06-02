INSERT INTO freddie.final
  SELECT
    multiIf(ln_harp_flg = 'Y', 'Is HARP',
        b.ln_id_harp != '', 'To HARP', 'None') AS harp_status,
    multiIf(ln_harp_flg = 'Y', ln_id_preharp,
        b.ln_id_harp != '', b.ln_id_harp, 'None') AS harp_ln_id,
    position(src_file, 'excl') > 0 ? 'Non-Standard' : 'Standard',
    a.*
  FROM
    freddie.n3sted AS a
  LEFT JOIN (
    SELECT
      ln_id_preharp,
      ln_id AS ln_id_harp
    FROM
      freddie.n3sted
    WHERE
      ln_harp_flg = 'Y'
      AND ln_id_preharp != '') AS b
  ON
    a.ln_id = b.ln_id_preharp;