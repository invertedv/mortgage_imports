CREATE TABLE freddie.trans
(
    dt                     Date,
    ln_id                  String,
    slr_chan_cd            LowCardinality(FixedString(1)),
    slr_name               LowCardinality(String),
    serv_name              LowCardinality(String),
    ln_orig_ir             Float32,
    ln_c_ir                Float32,
    ln_orig_prin           Float32,
    ln_c_prin              Float32,
    ln_orig_term           Int16,
    ln_fp_dt               Date,
    ln_age                 Int16,
    ln_rem_term_legal      Int16,
    ln_mat_dt              Nullable(Date),
    ln_orig_ltv            Int16,
    ln_orig_cltv           Int16,
    borr_num               Int16,
    borr_dti               Int16,
    borr_orig_fico         Int16,
    borr_first_time_flg    LowCardinality(FixedString(1)),
    ln_purp_cd             LowCardinality(FixedString(1)),
    prop_type_cd           LowCardinality(FixedString(2)),
    prop_num_unit          Float32,
    prop_occ_cd            LowCardinality(FixedString(1)),
    prop_st                LowCardinality(FixedString(2)),
    prop_msa_cd            LowCardinality(FixedString(5)),
    prop_zip3              LowCardinality(FixedString(3)),
    ln_mi_pct              Float32,
    ln_amort_cd            LowCardinality(FixedString(3)),
    ln_pp_pen_flg          LowCardinality(FixedString(1)),
    ln_dq_status_cd        LowCardinality(FixedString(2)),
    ln_mod_flg             LowCardinality(FixedString(1)),
    ln_zb_cd               LowCardinality(FixedString(3)),
    ln_zb_dt               Nullable(Date),
    ln_last_pay_dt         Nullable(Date),
    fcl_cost               Float32,
    fcl_pres_cost          Float32,
    fcl_recov_cost         Float32,
    fcl_misc_cost          Float32,
    fcl_taxes              Float32,
    fcl_net_prcds          Float32,
    fcl_ce_prcds           Float32,
    fcl_reprch_mw_prcds    Float32,
    mod_t_loss             Float32,
    ln_hrprog_flg          LowCardinality(FixedString(1)),
    ln_dq_accr_int         Float32,
    prop_val_mthd          LowCardinality(FixedString(1)),
    ln_highbal_flg         LowCardinality(FixedString(1)),
    borr_asst_plan         LowCardinality(FixedString(1)),
    ln_defrl_amt Float32,

/* New orig fields Not in Fannie */
    ln_id_preharp          LowCardinality(String),
    ln_harp_flg            LowCardinality(FixedString(1)),

/* New perf fields Not in Fannie */
/*    ln_repurch_flg         LowCardinality(FixedString(1)), /* NIF Y,N,<sp> */*/
    fcl_loss               Nullable(Float32), /* NIF, total loss Compare to fannie ln_t_credit_loss*/
    ln_stepmod_flg         LowCardinality(FixedString(1)), /* NIF Y,N <sp>=not a step mod */
    ln_dfrd_pay_flg        LowCardinality(FixedString(1)), /* NIF Y,N Deferred Payment Plan */
    ln_curr_eltv           Nullable(Float32), /* NIF estimated current LTV from Freddie */
    ln_zb_prin             Nullable(Float32), /* NIF: UPB just prior to zero balance */
    ln_dq_distr_flg        LowCardinality(FixedString(1)) /* NIF DQ due to natural disaster Y,<other> */

)
ENGINE = MergeTree()
ORDER BY (ln_id, dt)
