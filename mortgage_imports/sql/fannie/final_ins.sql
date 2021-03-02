INSERT INTO fannie.final1
  SELECT
    multiIf(b.old_ln_id != '', 'To HARP',
           c.old_ln_id != '', 'Is HARP',
	   'None') AS harp_status,
	   
    multiIf(b.old_ln_id != '', b.harp_ln_id,
           c.old_ln_id != '', c.old_ln_id,
	   '') AS harp_ln_id,
    a.*
  FROM
    fannie.n3sted AS a
  LEFT JOIN
    fannie.harp_map AS b
  ON
    a.ln_id = b.old_ln_id
  LEFT JOIN
    fannie.harp_map AS c
  ON
    a.ln_id = c.harp_ln_id;
