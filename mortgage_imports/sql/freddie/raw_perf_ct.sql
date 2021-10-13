/*

 NIF - means Not In Fannie data
 */
CREATE TABLE freddie.raw_perf
(
    ln_id                  String,
    month                  FixedString(6), /*YYYYMM*/
    ln_c_prin              Float32,
    ln_dq_status_cd        LowCardinality(FixedString(3)), /* Fannie is (2) */
    ln_age                 Int16,
    ln_rem_term_legal      LowCardinality(FixedString(3)),/*Int16,*/
    uw_defect_dt           String,
    ln_mod_flg             LowCardinality(FixedString(1)),
    ln_zb_cd               LowCardinality(FixedString(2)), /* Fannie is (3) */
    ln_zb_dt               String, /* YYYYMM, <blank> */
    ln_c_ir                Float32,
    ln_defrl_amt           Float32, /* Current deferred amt */
    ln_last_pay_dt         FixedString(6),
    fcl_ce_prcds           Nullable(Float32), /* MI proceeds */
    fcl_net_prcds          Nullable(Float32), /* net sales proceeds */
    fcl_reprch_mw_prcds    Nullable(Float32), /* other proceeds e.g. make whole, hazard ins*/
    fcl_cost               Nullable(Float32),
    fcl_recov_cost         Nullable(Float32),
    fcl_pres_cost          Nullable(Float32),
    fcl_taxes              Nullable(Float32),
    fcl_misc_cost          Nullable(Float32),
    fcl_loss               Nullable(Float32), /* NIF, total loss Compare to fannie ln_t_credit_loss*/
    mod_t_loss             Nullable(Float32),
    ln_stepmod_flg         LowCardinality(FixedString(1)), /* NIF Y,N <sp>=not a step mod */
    ln_dfrd_pay_flg        LowCardinality(FixedString(1)), /* NIF Y,N Deferred Payment Plan */
    ln_curr_eltv           Nullable(Float32), /* NIF estimated current LTV from Freddie */
    ln_zb_prin             Nullable(Float32), /* NIF: UPB just prior to zero balance */
    ln_dq_accr_int         Nullable(Float32),
    ln_dq_distr_flg        LowCardinality(FixedString(1)), /* NIF DQ due to natural disaster Y,<other> */
    borr_asst_plan         LowCardinality(FixedString(1)),
    mod_c_loss             Nullable(Float32),
    ln_ib_prin             Float32)
ENGINE = MergeTree()
ORDER BY (ln_id, month)
