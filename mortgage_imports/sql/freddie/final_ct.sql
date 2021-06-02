CREATE TABLE freddie.final (
  harp_status  LowCardinality(String),
  harp_ln_id LowCardinality(String),
  src_data LowCardinality(String),

  ln_id String,
  ln_bucket Int8,
  vintage LowCardinality(String),
  src_file LowCardinality(String),
/*  deal_id LowCardinality(String),*/
  slr_chan_cd LowCardinality(FixedString(1)),
  slr_name LowCardinality(String),
  serv_name LowCardinality(String), /* NEW */
  ln_id_preharp          LowCardinality(String),
  ln_harp_flg            LowCardinality(FixedString(1)),

  last_dt Date,
  last_upb Float32,
  last_dq_status_cd LowCardinality(FixedString(2)),
/*  last_pay_str LowCardinality(String),*/
  last_zb_cd LowCardinality(FixedString(3)),
  last_months_dq Int8,

  ln_orig_ir Float32,
  ln_orig_prin Float32,
/*  ln_iss_prin Float32,*/
  ln_orig_term Int16,
/*  ln_orig_dt Nullable(Date),*/
  ln_fp_dt Date,
  ln_orig_ltv Int16,
  ln_orig_cltv Int16,
  ln_purp_cd LowCardinality(FixedString(1)),
  ln_mi_pct Float32,
  ln_amort_cd LowCardinality(FixedString(3)),
  ln_pp_pen_flg LowCardinality(FixedString(1)),
/*  ln_amort_months Int16,*/
/*  ln_mi_can_flg LowCardinality(FixedString(2)),*/

  ln_zb_dt Nullable(Date),
/*  ln_remvd_prin Float32,*/
/*  ln_rprch_dt Nullable(Date),*/
/*  ln_frgv_amt Float32,*/
/*  ln_mi_type_cd LowCardinality(FixedString(1)),*/
/*  ln_t_credit_loss Float32,*/
  ln_hrprog_flg LowCardinality(FixedString(1)),
/*  ln_zb_chg_dt Nullable(Date),*/
/*  ln_hldbk_flg LowCardinality(FixedString(1)),*/
/*  ln_hldbk_dt Nullable(Date),*/
  ln_dq_accr_int Float32,
  ln_highbal_flg LowCardinality(FixedString(1)),
/*  ln_alt_dq_pcds LowCardinality(FixedString(1)),*/
/*  ln_alt_dq_res_cnt Int16,*/
  ln_defrl_amt Float32,

  prop_type_cd LowCardinality(FixedString(2)),
  prop_num_unit Int16,
  prop_occ_cd LowCardinality(FixedString(1)),
  prop_st LowCardinality(FixedString(2)),
  prop_msa_cd LowCardinality(FixedString(5)),
  prop_zip3 LowCardinality(FixedString(3)),
  prop_val_mthd LowCardinality(FixedString(1)),
  prop_orig_hpi Float32,
  prop_orig_val Float32,

  borr_num Int16,
  borr_dti Int16,
  borr_orig_fico Int16,
/*  coborr_orig_fico Int16,*/
  borr_first_time_flg LowCardinality(FixedString(1)),
/*  borr_iss_fico Int16,*/
/*  coborr_iss_fico Int16,*/

/*  borr_relo_flg LowCardinality(FixedString(1)),*/

/*  arm_io_flg LowCardinality(FixedString(1)),
  arm_io_end_dt Nullable(Date),
  arm_tsr5_flg LowCardinality(FixedString(1)),
  arm_type String,
  arm_tsr_period Int16,
  arm_ir_adj_freq Int16,
  arm_index_cd LowCardinality(String),
  arm_cap_strct LowCardinality(String),
  arm_init_ir_cap Float32,
  arm_per_ir_cap Float32,
  arm_life_ir_cap Float32,
  arm_margin Float32,
  arm_ball_flg LowCardinality(FixedString(1)),
  arm_plan_num Int16,*/

  rt_orig_mort15yr Float32,
  rt_orig_mort30yr Float32,
  rt_orig_mortarm5 Float32,
  rt_orig_treas10yr Float32,
  rt_orig_libor12mo Float32,
  rt_orig_libor1mo Float32,
  rt_orig_libor3mo Float32,

  monthly Nested(
    dt Date,
    age Int32,
    upb Float32,
    ir Float32,
    rem_term_legal Int32,
/*    rem_term_act Int32,*/
    mat_dt Date,
    dq_status_cd LowCardinality(FixedString(2)),
/*    pay_str LowCardinality(String),*/
    last_pay_dt Date,
/*    borr_c_fico Int16,*/
/*    coborr_c_fico Int16,*/
    zb_cd LowCardinality(FixedString(3)),
    months_dq Int8,

    mod_flg LowCardinality(FixedString(1)),
    borr_asst_plan LowCardinality(FixedString(1)),
/*    borr_hltv_refi_opt_flg LowCardinality(FixedString(1)),*/
/*    serv_name LowCardinality(String),*/
/*    serv_activity_flg LowCardinality(FixedString(1)),*/
/*    mserv_name LowCardinality(String),*/
    ln_repurch_flg LowCardinality(FixedString(1)), /* NEW */
    ln_curr_eltv Float32, /* NEW */

    prop_hpi Float32,
    prop_val Float32,
    ln_ltv Float32,
    ln_1stequity Float32,
    rt_mort15yr Float32,
    rt_mort30yr Float32,
    rt_mortarm5 Float32,
    rt_treas10yr Float32,
    rt_libor12mo Float32,
    rt_libor1mo Float32,
    rt_libor3mo Float32,
    unemp_rate Float32
    ),

  mods Nested(
    dt Date,
/*    curr_loss Float32,*/
    tot_loss Float32,
    ln_stepmod_flg LowCardinality(FixedString(1)), /* NEW */
    ln_dfrd_pay_flg LowCardinality(FixedString(1))/* NEW */
    ),

  fc Nested(
    dt Date,
/*    dispo_dt Nullable(Date),*/
    cost Float32,
    pres_cost Float32,
    recov_cost Float32,
    misc_cost Float32,
    taxes Float32,
    net_prcds Float32,
    ce_prcds Float32,
    reprch_mw_prcds Float32,

    fcl_loss Float32 /* NEW */
/*    other_prcds Float32,*/
/*    orig_list_dt Date,*/
/*    orig_list_price Float32,*/
/*    curr_list_dt Date,*/
/*    curr_list_price Float32,*/
/*    prin_write_off Float32*/
    )

/*  arm Nested(
    dt Date,
    arm_next_ir_adj_dt Date,
    arm_next_pay_adj_dt Date
    )*/
  )
ENGINE = MergeTree()
ORDER BY (ln_id)
PARTITION BY vintage;
