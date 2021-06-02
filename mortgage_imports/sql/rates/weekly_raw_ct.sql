CREATE TABLE rates.weekly_raw
(
    dt                                  Date,
    rt_mort15yr_wk                      Float32,
    rt_mort30yr_wk                      Float32,
    rt_mortarm5_wk                      Float32
)    
ENGINE = MergeTree()
ORDER BY (dt)
