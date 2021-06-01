INSERT INTO freddie.trans
  SELECT
    toDate(CONCAT(SUBSTR(month,1, 4), '-', SUBSTR(month,5, 2),'-01')) AS dt,
/*    deal_id,*/
    ln_id,
    slr_chan_cd = '9' ? 'U' : slr_chan_cd AS slr_chan_cd,
    lower(slr_name),
    lower(serv_name),
/*    mserv_name = '' ? 'unknown' : lower(mserv_name),*/
    ln_orig_ir,
    ln_c_ir,
    ln_orig_prin,
/*    ln_iss_prin,*/
    ln_c_prin = 0 AND ln_zb_cd = '!' ? ln_orig_prin : ln_c_prin,
    ln_orig_term,
    /* clickhouse always evaluates both legs of the IF so you have to do the ='' on both sides */
/*    ln_orig_dt = '' ? NULL :
      toDate(concat(substr(ln_orig_dt = '' ? '011970' : ln_orig_dt, 3, 4), '-',
      substr(ln_orig_dt = '' ? '011970' : ln_orig_dt, 1, 2), '-01')) AS ln_orig_dt,*/
    ln_fp_dt = '' ? NULL :
      toDate(concat(substr(ln_fp_dt = '' ? '011970' : ln_fp_dt, 1, 4), '-',
      substr(ln_fp_dt = '' ? '011970' : ln_fp_dt, 5, 2), '-01')) AS ln_fp_dt,
    ln_fp_dt IS NULL ? -1 : dateDiff('month', toStartOfMonth(ln_fp_dt), dt) AS ln_age,
    ln_rem_term_legal,
/*    ln_rem_term_act,*/
    toDate(concat(substr(ln_mat_dt = '' ? '011970' : ln_mat_dt, 1, 4), '-',
      substr(ln_mat_dt = '' ? '011970' : ln_mat_dt, 5, 2), '-01')) AS ln_mat_dt,
    ln_orig_ltv,
    ln_orig_cltv < ln_orig_ltv ? ln_orig_ltv : ln_orig_cltv,
    borr_num,
    borr_dti,
    borr_orig_fico,
/*    coborr_orig_fico,*/
    borr_first_time_flg,
    ln_purp_cd,
    prop_type_cd = '99' ? '!' : prop_type_cd AS prop_type_cd,
    prop_num_unit,
    prop_occ_cd = '9' ? 'U' : prop_occ_cd AS prop_occ_cd,
    prop_st,
    prop_msa_cd = '' ? '00000' : prop_msa_cd AS prop_msa,
    prop_zip3 = '' ? '000' : substr(prop_zip3, 1, 3) AS prop_zip3,
    ln_mi_pct,
    substr(ln_amort_cd, 1, 3) AS ln_amort_cd,
    ln_pp_pen_flg = '' ? '!' : ln_pp_pen_flg AS ln_pp_pen_flg,
/*    arm_io_flg = '' ? '!' : arm_io_flg AS arm_io_flg,*/
/*    arm_io_end_dt = '' ? NULL :
      toDate(concat(substr(arm_io_end_dt = '' ? '011970' : arm_io_end_dt, 3, 4), '-', substr(arm_io_end_dt = '' ? '011970' : arm_io_end_dt, 1, 2), '-01')) AS arm_io_end_dt,*/
/*    ln_amort_months,*/
    lower(ln_dq_status_cd) = 'reo' ? 'r' : substr(ln_dq_status_cd, 1, 2) AS ln_status_cd,
/*    ln_pay_hist_str,*/
    ln_mod_flg = '' ? '!' : ln_mod_flg AS ln_mod_flg,
/*    ln_mi_can_flg = '' ? '!' : ln_mi_can_flg AS ln_mi_can_flg,*/
    ln_zb_cd = '' ? '!' : ln_zb_cd AS ln_zb_cd,
    ln_zb_dt = '' ? NULL :
      toDate(concat(substr(ln_zb_dt = '' ? '011970' : ln_zb_dt, 1, 4), '-', substr(ln_zb_dt = '' ? '011970' : ln_zb_dt, 5, 2), '-01')) AS ln_zb_dt,
/*    ln_remvd_prin,*/
/*    ln_rprch_dt = '' ? NULL :
      toDate(concat(substr(ln_rprch_dt = '' ? '011970' : ln_rprch_dt, 3, 4), '-', substr(ln_rprch_dt = '' ? '011970' : ln_rprch_dt, 1, 2), '-01')) AS ln_rprch_dt,*/
/*    ln_sched_prin,*/
/*    ln_tot_prin,*/
/*    ln_usched_prin,*/
    toDate(concat(substr(ln_last_pay_dt = '' ? '011970' : ln_last_pay_dt, 1, 4), '-', substr(ln_last_pay_dt = '' ? '011970' : ln_last_pay_dt, 5, 2), '-01')) AS ln_last_pay_dt,
/*    fcl_dt = '' ? NULL :
      toDate(concat(substr(fcl_dt = '' ? '011970' : fcl_dt, 3, 4), '-', substr(fcl_dt = '' ? '011970' : fcl_dt, 1, 2), '-01')) AS fcl_dt,*/
/*toDate(concat(substr(fcl_dispo_dt = '' ? '011970' : fcl_dispo_dt, 3, 4), '-', substr(fcl_dispo_dt = '' ? '011970' : fcl_dispo_dt, 1, 2), '-01')) AS fcl_dispo_dt,*/
    coalesce(fcl_cost, 0.0) AS fcl_cost,
    coalesce(fcl_pres_cost, 0.0) AS fcl_pres_cost,
    coalesce(fcl_recov_cost, 0.0) AS fcl_recov_cost,
    coalesce(fcl_misc_cost, 0.0) AS fcl_misc_cost,
    coalesce(fcl_taxes, 0.0) AS fcl_taxes,
    coalesce(fcl_net_prcds, 0.0) AS fcl_net_prcds,
    coalesce(fcl_ce_prcds, 0.0) AS fcl_ce_prcds,
    coalesce(fcl_reprch_mw_prcds, 0.0) AS fcl_reprch_mw_prcds,
/*    fcl_other_prcds,*/
/*    ln_ni_prin,*/
/*    ln_frgv_amt,*/
/*toDate(concat(substr(fcl_orig_list_dt = '' ? '011970' : fcl_orig_list_dt, 3, 4), '-', substr(fcl_orig_list_dt = '' ? '011970' : fcl_orig_list_dt, 1, 2), '-01')) AS fcl_orig_list_dt,*/
/*    fcl_orig_list_price,*/
/*toDate(concat(substr(fcl_curr_list_dt = '' ? '011970' : fcl_curr_list_dt, 3, 4), '-', substr(fcl_curr_list_dt = '' ? '011970' : fcl_curr_list_dt, 1, 2), '-01')) AS fcl_curr_list_dt,*/
/*    fcl_curr_list_price,*/
/*    borr_iss_fico,*/
/*    coborr_iss_fico,*/
/*    borr_c_fico,*/
/*    coborr_c_fico,*/
/*    ln_mi_type_cd = '' ? '!' : ln_mi_type_cd AS ln_mi_type_cd,*/
/*    serv_activity_flg = '' ? '!' : serv_activity_flg AS serv_activity_flg,*/
/*    mod_c_loss,*/
    coalesce(mod_t_loss, 0.0) AS mod_t_loss,
/*    ln_c_credit_loss,*/
/*    ln_t_credit_loss,*/
    ln_hrprog_flg = '' ? '!' : ln_hrprog_flg AS ln_hrprog_flg,
/*    fcl_prin_wo,*/
/*    borr_relo_flg = '' ? '!' : borr_relo_flg AS borr_relo_flg,*/
/*    ln_zb_chg_dt = '' ? NULL :
      toDate(concat(substr(ln_zb_chg_dt = '' ? '011970' : ln_zb_chg_dt, 3, 4), '-', substr(ln_zb_chg_dt = '' ? '011970' : ln_zb_chg_dt, 1, 2), '-01')) AS ln_zb_chg_dt,*/
/*    ln_hldbk_flg = '' ? '!' : ln_hldbk_flg AS ln_hldbk_flg,*/
/*    ln_hldbk_dt = '' ? NULL :
      toDate(concat(substr(ln_hldbk_dt = '' ? '011970' : ln_hldbk_dt, 3, 4), '-', substr(ln_hldbk_dt = '' ? '011970' : ln_hldbk_dt, 1, 2), '-01')) AS ln_hldbk_dt,*/
    coalesce(ln_dq_accr_int, 0.0) AS ln_dq_accr_int,
    multiIf(prop_val_mthd IN ('', '9'), '!', prop_val_mthd = '2', 'A', prop_val_mthd = '3', 'O', '!') AS prop_val_mthd,
    ln_highbal_flg = '' ? '!' : ln_highbal_flg AS ln_highbal_flg,
/*    arm_tsr5_flg = '' ? '!' : arm_tsr5_flg AS arm_tsr5_flg,
    arm_type = '' ? '!' : lower(arm_type) AS arm_type,
    arm_tsr_period,
    arm_ir_adj_freq,
    arm_next_ir_adj_dt = '' ? NULL :
      toDate(concat(substr(arm_next_ir_adj_dt = '' ? '011970' : arm_next_ir_adj_dt, 3, 4), '-', substr(arm_next_ir_adj_dt = '' ? '011970' : arm_next_ir_adj_dt, 1, 2), '-01')) AS arm_next_ir_adj_dt,
    arm_next_pay_adj_dt = '' ? NULL :
      toDate(concat(substr(arm_next_pay_adj_dt = '' ? '011970' : arm_next_pay_adj_dt, 3, 4), '-', substr(arm_next_pay_adj_dt = '' ? '011970' : arm_next_pay_adj_dt, 1, 2), '-01')) AS arm_next_pay_adj_dt,
    arm_index_cd = '' ? '!' : lower(arm_index_cd) AS arm_index_cd,
    arm_cap_strct = '' ? '!' : lower(arm_cap_strct) AS arm_cap_strct,
    arm_init_ir_cap,
    arm_per_ir_cap,
    arm_life_ir_cap,
    arm_margin,
    arm_ball_flg = '' ? '!' : arm_ball_flg AS arm_ball_flg,
    arm_plan_num,*/
    borr_asst_plan = '' ? '!' : borr_asst_plan AS borr_asst_plan,
/*    borr_hltv_refi_opt_flg = '' ? '!' : borr_hltv_refi_opt_flg AS borr_hltv_refi_opt_flg,*/
/*    deal_name = '' ? '!' : lower(deal_name) AS deal_name,
    fcl_reprch_mw_prcds_flg = '' ? '!' : fcl_reprch_mw_prcds_flg AS fcl_reprch_mw_prcds_flg,
    ln_alt_dq_pcds,
    ln_alt_dq_res_cnt,*/
    coalesce(ln_defrl_amt, 0.0) AS ln_defrl_amt,
/* New orig fields Not in Fannie */
    ln_id_preharp,
    ln_harp_flg,

/* New perf fields Not in Fannie */
    upper(ln_repurch_flg) IN ('Y', 'N') ? upper(ln_repurch_flg) : '!' AS ln_repurch_flg,    /* NIF Y,N,<sp> */
    fcl_loss,              /* NIF, total loss Compare to fannie ln_t_credit_loss*/
    upper(ln_stepmod_flg) IN ('Y', 'N') ? upper(ln_stepmod_flg) : '!' AS ln_stepmod_flg,    /* NIF Y,N <sp>=not a step mod */
    upper(ln_dfrd_pay_flg) IN ('Y', 'N') ? upper(ln_dfrd_pay_flg) : '!' AS ln_dfrd_pay_flg, /* NIF Y,N Deferred Payment Plan */
    ln_curr_eltv,          /* NIF estimated current LTV from Freddie */
    ln_zb_prin,            /* NIF: UPB just prior to zero balance */
    upper(ln_dq_distr_flg) in ('Y', 'N') ? upper(ln_dq_distr_flg) : '!' AS ln_dq_distr_flg  /* NIF DQ due to natural disaster Y,<other> */
  FROM
    freddie.raw_orig AS o
  JOIN
    freddie.raw_perf AS p
  ON
    o.ln_id = p.ln_id;
