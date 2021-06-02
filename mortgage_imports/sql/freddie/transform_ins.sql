INSERT INTO freddie.trans
    SELECT
        toDate(CONCAT(SUBSTR(month,1, 4), '-', SUBSTR(month,5, 2),'-01')) AS dt,
        ln_id,
        slr_chan_cd = '9' ? 'U' : slr_chan_cd AS slr_chan_cd,
        lower(slr_name),
        lower(serv_name),
        ln_orig_ir,
        ln_c_ir,
        ln_orig_prin,
        ln_c_prin = 0 AND ln_zb_cd = '!' ? ln_orig_prin : ln_c_prin,
        ln_orig_term,
        ln_fp_dt = '' ? toDate('1970-01-01') :
            toDate(concat(substr(ln_fp_dt = '' ? '011970' : ln_fp_dt, 1, 4), '-',
            substr(ln_fp_dt = '' ? '011970' : ln_fp_dt, 5, 2), '-01')) AS ln_fp_dt,
        ln_fp_dt IS NULL ? -1 : dateDiff('month', toStartOfMonth(ln_fp_dt), dt) AS ln_age,
        toInt16OrZero(ln_rem_term_legal) AS ln_rem_term_legal,
        toDate(concat(substr(ln_mat_dt = '' ? '011970' : ln_mat_dt, 1, 4), '-',
          substr(ln_mat_dt = '' ? '011970' : ln_mat_dt, 5, 2), '-01')) AS ln_mat_dt,
        ln_orig_ltv > 900 ? 0.0 : ln_orig_ltv,
        multiIf(ln_orig_cltv > 900 AND ln_orig_ltv < 900, ln_orig_ltv,
                ln_orig_cltv > 900, 0.0,
                ln_orig_cltv < ln_orig_ltv, ln_orig_ltv, ln_orig_cltv),
        borr_num > 90 ? 1 : borr_num,
        borr_dti > 900 ? 0 : borr_dti,
        borr_orig_fico > 950 ? 0 : borr_orig_fico,
        borr_first_time_flg = '9' ? 'N' : borr_first_time_flg,
        ln_purp_cd = '9' ? 'U' : ln_purp_cd,
        prop_type_cd = '99' ? '!' : prop_type_cd AS prop_type_cd,
        prop_num_unit,
        prop_occ_cd = '9' ? 'U' : prop_occ_cd AS prop_occ_cd,
        prop_st,
        prop_msa_cd = '' ? '00000' : prop_msa_cd AS prop_msa,
        prop_zip3 = '' OR prop_zip3 = '00' ? '000' : substr(prop_zip3, 1, 3) AS prop_zip3,
        ln_mi_pct > 900 ? 0 : ln_mi_pct,
        substr(ln_amort_cd, 1, 3) AS ln_amort_cd,
        ln_pp_pen_flg = '' ? '!' : ln_pp_pen_flg AS ln_pp_pen_flg,
        multiIf(substring(ln_dq_status_cd, 1, 1) = '-', '0',
          lower(ln_dq_status_cd) = 'reo' ? 'r' : substr(ln_dq_status_cd, 1, 2)) AS ln_status_cd,
        ln_mod_flg = '' ? 'N' : ln_mod_flg AS ln_mod_flg,
        ln_zb_cd = '' ? '!' : ln_zb_cd AS ln_zb_cd,
        ln_zb_dt = '' ? NULL :
          toDate(concat(substr(ln_zb_dt = '' ? '011970' : ln_zb_dt, 1, 4), '-', substr(ln_zb_dt = '' ? '011970' : ln_zb_dt, 5, 2), '-01')) AS ln_zb_dt,
        toDate(concat(substr(ln_last_pay_dt = '' ? '011970' : ln_last_pay_dt, 1, 4), '-', substr(ln_last_pay_dt = '' ? '011970' : ln_last_pay_dt, 5, 2), '-01')) AS ln_last_pay_dt,
        coalesce(fcl_cost, 0.0) AS fcl_cost,
        coalesce(fcl_pres_cost, 0.0) AS fcl_pres_cost,
        coalesce(fcl_recov_cost, 0.0) AS fcl_recov_cost,
        coalesce(fcl_misc_cost, 0.0) AS fcl_misc_cost,
        coalesce(fcl_taxes, 0.0) AS fcl_taxes,
        coalesce(fcl_net_prcds, 0.0) AS fcl_net_prcds,
        coalesce(fcl_ce_prcds, 0.0) AS fcl_ce_prcds,
        coalesce(fcl_reprch_mw_prcds, 0.0) AS fcl_reprch_mw_prcds,
        coalesce(mod_t_loss, 0.0) AS mod_t_loss,
        ln_hrprog_flg = '' ? 'N' : ln_hrprog_flg AS ln_hrprog_flg,
        coalesce(ln_dq_accr_int, 0.0) AS ln_dq_accr_int,
        multiIf(prop_val_mthd IN ('', '9'), '!', prop_val_mthd = '2', 'A', prop_val_mthd = '3', 'O', '!') AS prop_val_mthd,
        ln_highbal_flg = '' ? 'N' : ln_highbal_flg AS ln_highbal_flg,
        borr_asst_plan = '' ? '!' : borr_asst_plan AS borr_asst_plan,
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
