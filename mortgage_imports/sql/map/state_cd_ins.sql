INSERT INTO map.st_cd
  SELECT
    prop_state_name,
    trim(prop_st),
    trim(prop_st_cd)
  FROM
    map.st_cd_raw
    
