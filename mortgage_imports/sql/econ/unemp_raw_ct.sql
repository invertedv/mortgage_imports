CREATE TABLE econ.XXXXX
(
    id                       String,
    yr_str                   String,
    mo_str                   String,
    value                    String,
    note                     Nullable(String)
)    
ENGINE = MergeTree()
ORDER BY (id)
