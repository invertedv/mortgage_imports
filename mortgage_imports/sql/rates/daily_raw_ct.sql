/*
 FRED II has discontinued LIBOR rate series
 */
CREATE TABLE rates.daily_raw
(
    dt                                Date,
    rt_treas10yr_dly                  Float32
/*    rt_libor12mo_dly                  Float32,
    rt_libor1mo_dly                   Float32,
    rt_libor3mo_dly                   Float32*/
)    
ENGINE = MergeTree()
ORDER BY (dt)
