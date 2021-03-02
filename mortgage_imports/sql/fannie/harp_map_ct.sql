CREATE TABLE fannie.harp_map
(
    old_ln_id String,
    harp_ln_id String)
ENGINE = MergeTree()
ORDER BY (old_ln_id);

    
