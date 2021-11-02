CREATE TABLE fannie.raw
(
    deal_id                        String,
    ln_id                          String,
    month                          FixedString(6),
    slr_chan_cd                    LowCardinality(FixedString(1)),
    slr_name                       LowCardinality(String),
    serv_name                      LowCardinality(String),
    mserv_name                     LowCardinality(String),
    ln_orig_ir                     Float32,
    ln_c_ir                        Float32,
    ln_orig_prin                   Float32,
    ln_iss_prin                    Float32,
    ln_c_prin                      Float32,
    ln_orig_term                   Int16,
    ln_orig_dt                     FixedString(6),
    ln_fp_dt                       FixedString(6),
    ln_age                         Int16,
    ln_rem_term_legal              Int16,
    ln_rem_term_act                Int16,
    ln_mat_dt                      FixedString(6),
    ln_orig_ltv                    Int16,
    ln_orig_cltv                   Int16,
    borr_num                       Int16,
    borr_dti                       Int16,
    borr_orig_fico                 Int16,
    coborr_orig_fico               Int16,
    borr_first_time_flg            LowCardinality(FixedString(1)),
    ln_purp_cd                     LowCardinality(FixedString(1)),
    prop_type_cd                   LowCardinality(FixedString(2)),
    prop_num_unit                  Int16,
    prop_occ_cd                    LowCardinality(FixedString(1)),
    prop_st                        LowCardinality(FixedString(2)),
    prop_msa_cd                    LowCardinality(FixedString(5)),
    prop_zip3                      LowCardinality(FixedString(3)),
    ln_mi_pct                      Float32,
    ln_amort_cd                    LowCardinality(FixedString(3)),
    ln_pp_pen_flg                  LowCardinality(FixedString(1)),
    arm_io_flg                     LowCardinality(FixedString(1)),
    arm_io_end_dt                  FixedString(6),
    ln_amort_months                Int16,
    ln_dq_status_cd                LowCardinality(FixedString(2)),
    ln_pay_hist_str                String,
    ln_mod_flg                     LowCardinality(FixedString(1)),
    ln_mi_can_flg                  LowCardinality(FixedString(2)),
    ln_zb_cd                       LowCardinality(FixedString(3)),
    ln_zb_dt                       FixedString(6),
    ln_remvd_prin                  Float32,
    ln_rprch_dt                    FixedString(6),
    ln_sched_prin                  Float32,
    ln_tot_prin                    Float32,
    ln_usched_prin                 Float32,
    ln_last_pay_dt                 FixedString(6),
    fcl_dt                         FixedString(6),
    fcl_dispo_dt                   FixedString(6),
    fcl_cost                       Float32,
    fcl_pres_cost                  Float32,
    fcl_recov_cost                 Float32,
    fcl_misc_cost                  Float32,
    fcl_taxes                      Float32,
    fcl_net_prcds                  Float32,
    fcl_ce_prcds                   Float32,
    fcl_reprch_mw_prcds            Float32,
    fcl_other_prcds                Float32,
    ln_ni_prin                     Float32,
    ln_frgv_amt                    Float32,
    fcl_orig_list_dt               FixedString(6),
    fcl_orig_list_price            Float32,
    fcl_curr_list_dt               FixedString(6),
    fcl_curr_list_price            Float32,
    borr_iss_fico                  Int16,
    coborr_iss_fico                Int16,
    borr_c_fico                    Int16,
    coborr_c_fico                  Int16,
    ln_mi_type_cd                  LowCardinality(FixedString(1)),
    serv_activity_flg              LowCardinality(FixedString(1)),
    mod_c_loss                     Float32,
    mod_t_loss                     Float32,
    ln_c_credit_loss               Float32,
    ln_t_credit_loss               Float32,
    ln_hrprog_flg                  LowCardinality(FixedString(1)),
    fcl_prin_wo                    Float32,
    borr_relo_flg                  LowCardinality(FixedString(1)),
    ln_zb_chg_dt                   FixedString(6),
    ln_hldbk_flg                   LowCardinality(FixedString(1)),
    ln_hldbk_dt                    FixedString(6),
    ln_dq_accr_int                 Float32,
    prop_val_mthd                  LowCardinality(FixedString(1)),
    ln_highbal_flg                 LowCardinality(FixedString(1)),
    arm_tsr5_flg                   LowCardinality(FixedString(1)),
    arm_type                       String,
    arm_tsr_period                 Int16,
    arm_ir_adj_freq                Int16,
    arm_next_ir_adj_dt             FixedString(6),
    arm_next_pay_adj_dt            FixedString(6),
    arm_index_cd                   String,
    arm_cap_strct                  String,
    arm_init_ir_cap                Float32,
    arm_per_ir_cap                 Float32,
    arm_life_ir_cap                Float32,
    arm_margin                     Float32,
    arm_ball_flg                   LowCardinality(FixedString(1)),
    arm_plan_num                   Int16,
    borr_asst_plan                 LowCardinality(FixedString(1)),
    borr_hltv_refi_opt_flg         LowCardinality(FixedString(1)),
    deal_name                      String,
    fcl_reprch_mw_prcds_flg        LowCardinality(FixedString(1)),
    ln_alt_dq_pcds                 LowCardinality(FixedString(1)),
    ln_alt_dq_res_cnt              Int16,
    ln_defrl_amt                   Float32
    <extra_fields>
)
ENGINE = MergeTree()
ORDER BY (ln_id)
