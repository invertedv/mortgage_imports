CREATE TABLE econ.XXXXX
(
    id                       String,
    yr_str                   String,
    mo_str                   String,
    value                    String
)
ENGINE = MergeTree()
ORDER BY (id)
