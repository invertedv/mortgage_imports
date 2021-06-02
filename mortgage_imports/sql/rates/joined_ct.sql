CREATE TABLE rates.monthly
(
    dt                        Date,
    rt_mort15yr               Float32,
    rt_mort30yr               Float32,
    rt_mortarm5               Float32,

    rt_treas10yr              Float32,
    rt_libor12mo              Float32,
    rt_libor1mo               Float32,
    rt_libor3mo               Float32
)    
ENGINE = MergeTree()
ORDER BY (dt)
