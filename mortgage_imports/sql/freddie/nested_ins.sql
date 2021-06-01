INSERT INTO freddie.n3sted
  SELECT
    ln_id String,
    toInt8(20.0 * rand32() / 4294967295.0) AS ln_bucket,
    toYear(ln_fp_dt) > 1970 ?
      concat(cast(toYear(ln_fp_dt) AS String),'Q',
        cast(toQuarter(ln_fp_dt) AS String)) : 'Missing' AS vintage,
    'XXXXXX',
/*    max(deal_id) AS deal_id,*/
    max(slr_chan_cd) AS slr_chan_cd,
    max(slr_name) AS slr_name,
    max(serv_name) AS serv_name,
    max(ln_id_preharp) AS ln_id_pre_harp,
    max(ln_harp_flg) AS ln_harp_flg,

    arrayElement(groupArray(dt), length(groupArray(dt))) AS last_dt,
    arrayElement(groupArray(ln_c_prin1), length(groupArray(dt))) AS last_upb,
    arrayElement(groupArray(ln_dq_status_cd), length(groupArray(dt))) AS last_dq_status_cd,
/*    arrayElement(groupArray(ln_pay_hist_str), length(groupArray(dt))) AS last_pay_str,*/
    arrayElement(groupArray(ln_zb_cd), length(groupArray(dt))) AS last_zb_cd,
    toInt8OrNull(arrayElement(groupArray(ln_dq_status_cd), length(groupArray(dt)))) IS NULL ? -1 :
      toInt8OrNull(arrayElement(groupArray(ln_dq_status_cd), length(groupArray(dt)))) AS last_months_dq,

    max(ln_orig_ir) AS ln_orig_ir,
    max(ln_orig_prin1) AS ln_orig_prin,
/*    max(ln_iss_prin) AS ln_iss_prin,*/
    max(ln_orig_term) AS ln_orig_term,
/*    max(ln_orig_dt) AS ln_orig_dt,*/
    max(ln_fp_dt) AS ln_fp_dt,
    max(ln_orig_ltv1) AS ln_orig_ltv,
    max(ln_orig_cltv) AS ln_orig_cltv,
    max(ln_purp_cd) AS ln_purp_cd,
    max(ln_mi_pct) AS ln_mi_pct,
    max(ln_amort_cd) AS ln_amort_cd,
    max(ln_pp_pen_flg) AS ln_pp_pen_flg,
/*    max(ln_amort_months) AS ln_amort_months,*/
/*    max(ln_mi_can_flg) AS ln_mi_can_flg,*/

    max(ln_zb_dt) AS ln_zb_dt,
/*    max(ln_remvd_prin) AS ln_remvd_prin,*/
/*    max(ln_rprch_dt) AS ln_rprch_dt,*/
/*    max(ln_frgv_amt) AS ln_frgv_amt,*/
/*    max(ln_mi_type_cd) AS ln_mi_type_cd,*/

/*    max(ln_t_credit_loss) AS ln_t_credit_loss,*/
    max(ln_hrprog_flg) AS ln_hrprog_flg,
/*    max(ln_zb_chg_dt) AS ln_zb_chg_dt,*/
/*    max(ln_hldbk_flg) AS ln_hldbk_flg,*/
/*    max(ln_hldbk_dt) AS ln_hldbk_dt,*/
    max(ln_dq_accr_int) AS ln_dq_accr_int,
    max(ln_highbal_flg) AS ln_highbal_flg,
/*    max(ln_alt_dq_pcds) AS ln_alt_dq_pcds,*/
/*    max(ln_alt_dq_res_cnt) AS ln_alt_dq_res_cnt,*/
    max(ln_defrl_amt) AS ln_defrl_amt,

    max(prop_type_cd) AS prop_type_cd,
    max(prop_num_unit) AS prop_num_unit,
    max(prop_occ_cd) AS prop_occ_cd,
    max(prop_st) AS prop_st,
    max(prop_msa_cd) AS prop_msa_cd,
    max(prop_zip3) AS prop_zip3,
    max(prop_val_mthd) AS prop_val_mthd,
    max(prop_orig_hpi1) AS prop_orig_hpi,
    max(ln_orig_ltv1) > 0 ? max(ln_orig_prin1) / (max(ln_orig_ltv1) / 100.0) : 0  AS prop_orig_val,

    max(borr_num) AS borr_num,
    max(borr_dti) AS borr_dti,
    max(borr_orig_fico) AS borr_orig_fico,
/*    max(coborr_orig_fico) AS coborr_orig_fico,*/
    max(borr_first_time_flg) AS borr_first_time_flg,
/*    max(borr_iss_fico) AS borr_iss_fico,*/
/*    max(coborr_iss_fico) AS coborr_iss_fico,*/
/*    max(borr_relo_flg) AS borr_relo_flg,*/

/*    max(arm_io_flg) AS arm_io_flg,
    max(arm_io_end_dt) AS arm_io_end_dt,
    max(arm_tsr5_flg) AS arm_tsr5_flg,
    max(arm_type) AS arm_type,
    max(arm_tsr_period) AS arm_tsr_period,
    max(arm_ir_adj_freq) AS arm_ir_adj_freq,
    max(arm_index_cd) AS arm_index_cd,
    max(arm_cap_strct) AS arm_cap_strct,
    max(arm_init_ir_cap) AS arm_init_ir_cap,
    max(arm_per_ir_cap) AS arm_per_ir_cap,
    max(arm_life_ir_cap) AS arm_life_ir_cap,
    max(arm_margin) AS arm_margin,
    max(arm_ball_flg) AS arm_ball_flg,
    max(arm_plan_num) AS arm_plan_num,*/

    max(rt_orig_mort15yr),
    max(rt_orig_mort30yr),
    max(rt_orig_mortarm5),
    max(rt_orig_treas10yr),
    max(rt_orig_libor12mo),
    max(rt_orig_libor1mo),
    max(rt_orig_libor3mo),

    groupArray(dt),
    groupArray(ln_age),
    groupArray(ln_c_prin1),
    groupArray(ln_c_ir),
    groupArray(ln_rem_term_legal),
/*    groupArray(ln_rem_term_act),*/
    groupArray(ln_mat_dt),
    groupArray(ln_dq_status_cd),
/*    groupArray(ln_pay_hist_str),*/
    groupArray(ln_last_pay_dt),
/*    groupArray(borr_c_fico),*/
/*    groupArray(coborr_c_fico),*/

    groupArray(ln_zb_cd),
    groupArray(toInt8OrNull(ln_dq_status_cd) IS NULL ? 0 : toInt8OrNull(ln_dq_status_cd)),

    groupArray(ln_mod_flg),
    groupArray(borr_asst_plan),
    groupArray(ln_repurch_flg),
    groupArray(ln_curr_eltv is NULL ? 0.0 : ln_curr_eltv),
/*    groupArray(borr_hltv_refi_opt_flg),*/

/*    groupArray(serv_name),*/
/*    groupArray(serv_activity_flg),*/
/*    groupArray(mserv_name),*/
    groupArray(prop_dt_hpi1),
    /* updated property value */
    /* ln_orig_prin1 / (ln_orig_ltv1 / 100.0) is original property value */
    groupArray(ln_orig_ltv1 > 0 AND prop_dt_hpi1 > 0 ? (prop_dt_hpi1 / prop_orig_hpi1) * ln_orig_prin1 / (ln_orig_ltv1 / 100.0) : 0.0),
    /* updated ltv */
    groupArray(ln_orig_ltv1 > 0 AND prop_dt_hpi1 > 0 ? 100.0 * ln_c_prin1 / ((prop_dt_hpi1 / prop_orig_hpi1) * ln_orig_prin1 / (ln_orig_ltv1 / 100.0)) : 0.0),
    /* updated 1st lien equity */
    groupArray(ln_orig_ltv1 > 0 AND prop_dt_hpi1 > 0 ? (prop_dt_hpi1 / prop_orig_hpi1) * ln_orig_prin1 / (ln_orig_ltv1 / 100.0) - ln_c_prin1 : 0.0),

    groupArray(rt_mort15yr),
    groupArray(rt_mort30yr),
    groupArray(rt_mortarm5),
    groupArray(rt_treas10yr),
    groupArray(rt_libor12mo),
    groupArray(rt_libor1mo),
    groupArray(rt_libor3mo),
    groupArray(unemp_rate),

    groupArray(ln_mod_flg = 'Y' ? dt : NULL),
/*    groupArray(ln_mod_flg = 'Y' ? mod_c_loss : NULL),*/
    groupArray(ln_mod_flg = 'Y' ? mod_t_loss : NULL),
    groupArray(ln_mod_flg = 'Y' ? ln_stepmod_flg : NULL),
    groupArray(ln_mod_flg = 'Y' ? ln_dfrd_pay_flg : NULL),

    groupArray(tot_fcl_loss IS NOT NULL ? dt : NULL),
/*    groupArray(dt IS NOT NULL ? fcl_dispo_dt : NULL),*/
    groupArray(tot_fcl_loss IS NOT NULL ? IF(fcl_cost IS NULL, 0.0, fcl_cost) : NULL),
    groupArray(tot_fcl_loss IS NOT NULL ? IF(fcl_pres_cost IS NULL, 0.0, fcl_pres_cost) : NULL),
    groupArray(tot_fcl_loss IS NOT NULL ? IF(fcl_recov_cost IS NULL, 0.0, fcl_recov_cost) : NULL),
    groupArray(tot_fcl_loss IS NOT NULL ? IF(fcl_misc_cost IS NULL, 0.0, fcl_misc_cost) : NULL),
    groupArray(tot_fcl_loss IS NOT NULL ? IF(fcl_taxes IS NULL, 0.0, fcl_taxes) : NULL),
    groupArray(tot_fcl_loss IS NOT NULL ? IF(fcl_net_prcds IS NULL, 0.0, fcl_net_prcds) : NULL),
    groupArray(tot_fcl_loss IS NOT NULL ? IF(fcl_ce_prcds IS NULL, 0.0, fcl_ce_prcds) : NULL),
    groupArray(tot_fcl_loss IS NOT NULL ? IF(fcl_reprch_mw_prcds IS NULL, 0.0, fcl_reprch_mw_prcds) : NULL),
    groupArray(tot_fcl_loss IS NOT NULL ? IF(fcl_loss IS NULL, 0.0, fcl_loss) : NULL)

/*    groupArray(fcl_dt IS NOT NULL ? fcl_other_prcds : NULL),*/
/*    groupArray(fcl_dt IS NOT NULL ? fcl_orig_list_dt : NULL),*/
/*    groupArray(fcl_dt IS NOT NULL ? fcl_orig_list_price : NULL),*/
/*    groupArray(fcl_dt IS NOT NULL ? fcl_curr_list_dt : NULL),*/
/*    groupArray(fcl_dt IS NOT NULL ? fcl_curr_list_price : NULL),*/
/*    groupArray(fcl_dt IS NOT NULL ? fcl_prin_wo : NULL),*/

/*    groupArray(arm_next_ir_adj_dt IS NOT NULL or arm_next_pay_adj_dt IS NOT NULL ? dt : NULL),*/
/*    groupArray(arm_next_ir_adj_dt IS NOT NULL or arm_next_pay_adj_dt IS NOT NULL ? (arm_next_ir_adj_dt IS NOT NULL ? arm_next_ir_adj_dt : toDate('1970-01-01')) : NULL),*/
/*    groupArray(arm_next_ir_adj_dt IS NOT NULL or arm_next_pay_adj_dt IS NOT NULL ? (arm_next_pay_adj_dt IS NOT NULL ? arm_next_pay_adj_dt : toDate('1970-01-01')) : NULL)*/
  FROM
    freddie.with_hpi AS f
  JOIN (
    SELECT
      ln_id,
      max(fcl_loss) AS tot_fcl_loss
    FROM
      freddie.with_hpi
    GROUP BY ln_id) AS b
  ON
    f.ln_id = b.ln_id
  GROUP BY ln_id;
