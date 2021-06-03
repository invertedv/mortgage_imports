CREATE TABLE unified.frannie (
  harp_status          LowCardinality(String),
  harp_ln_id           LowCardinality(String),
  src_data             LowCardinality(String),

  ln_id                String,
  ln_bucket            Int8,
  vintage              LowCardinality(String),
  src_file             LowCardinality(String),
  slr_chan_cd          LowCardinality(FixedString(1)),
  slr_name             LowCardinality(String),
  serv_name            LowCardinality(String),

  last_dt              Date,
  last_upb             Float32,
  last_dq_status_cd    LowCardinality(FixedString(2)),
  last_zb_cd           LowCardinality(FixedString(3)),
  last_months_dq       Int8,

  ln_orig_ir           Float32,
  ln_orig_prin         Float32,
  ln_orig_term         Int16,
  ln_fp_dt             Date,
  ln_orig_ltv          Int16,
  ln_orig_cltv         Int16,
  ln_purp_cd           LowCardinality(FixedString(1)),
  ln_mi_pct            Float32,
  ln_amort_cd          LowCardinality(FixedString(3)),
  ln_pp_pen_flg        LowCardinality(FixedString(1)),

  ln_zb_dt             Nullable(Date),
  ln_hrprog_flg        LowCardinality(FixedString(1)),
  ln_dq_accr_int       Float32,
  ln_highbal_flg       LowCardinality(FixedString(1)),
  ln_defrl_amt         Float32,

  prop_type_cd         LowCardinality(FixedString(2)),
  prop_num_unit        Int16,
  prop_occ_cd          LowCardinality(FixedString(1)),
  prop_st              LowCardinality(FixedString(2)),
  prop_msa_cd          LowCardinality(FixedString(5)),
  prop_zip3            LowCardinality(FixedString(3)),
  prop_val_mthd        LowCardinality(FixedString(1)),
  prop_orig_hpi        Float32,
  prop_orig_val        Float32,

  borr_num             Int16,
  borr_dti             Int16,
  borr_orig_fico       Int16,
  borr_first_time_flg  LowCardinality(FixedString(1)),

  rt_orig_mort15yr     Float32,
  rt_orig_mort30yr     Float32,
  rt_orig_mortarm5     Float32,
  rt_orig_treas10yr    Float32,
  rt_orig_libor12mo    Float32,
  rt_orig_libor1mo     Float32,
  rt_orig_libor3mo     Float32,
  first_mod_index      Int16,

  monthly Nested(
    dt                 Date,
    age                Int32,
    upb                Float32,
    ir                 Float32,
    rem_term_legal     Int32,
    mat_dt             Date,
    dq_status_cd       LowCardinality(FixedString(2)),
    last_pay_dt        Date,
    zb_cd              LowCardinality(FixedString(3)),
    months_dq          Int8,

    mod_flg            LowCardinality(FixedString(1)),
    mod_sticky_flg     LowCardinality(FixedString(1)),
    borr_asst_plan     LowCardinality(FixedString(1)),

    prop_hpi           Float32,
    prop_val           Float32,
    ln_ltv             Float32,
    ln_1stequity       Float32,
    rt_mort15yr        Float32,
    rt_mort30yr        Float32,
    rt_mortarm5        Float32,
    rt_treas10yr       Float32,
    rt_libor12mo       Float32,
    rt_libor1mo        Float32,
    rt_libor3mo        Float32,
    unemp_rate         Float32
    ),

  mods Nested(
    dt Date,
    tot_loss Float32
    ),

  fc Nested(
    dt                 Date,
    cost               Float32,
    pres_cost          Float32,
    recov_cost         Float32,
    misc_cost          Float32,
    taxes              Float32,
    net_prcds          Float32,
    ce_prcds           Float32,
    reprch_mw_prcds    Float32
    )

  )
ENGINE = MergeTree()
ORDER BY (ln_id)
PARTITION BY vintage;
