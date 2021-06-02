/*
 Insert the union of Freddie and Fannie data
*/
INSERT INTO TABLE unified.frannie
    SELECT
        *
    FROM (
        SELECT
            harp_status,
            harp_ln_id,
            concat('freddie:', src_data),

            ln_id,
            ln_bucket,
            vintage,
            src_file,
            slr_chan_cd,
            slr_name,
            serv_name,

            last_dt,
            last_upb,
            last_dq_status_cd,
            last_zb_cd,
            last_months_dq,

            ln_orig_ir,
            ln_orig_prin,
            ln_orig_term,
            ln_fp_dt,
            ln_orig_ltv,
            ln_orig_cltv,
            ln_purp_cd,
            ln_mi_pct,
            ln_amort_cd,
            ln_pp_pen_flg,

            ln_zb_dt,
            ln_hrprog_flg,
            ln_dq_accr_int,
            ln_highbal_flg,
            ln_defrl_amt,

            prop_type_cd,
            prop_num_unit,
            prop_occ_cd,
            prop_st,
            prop_msa_cd,
            prop_zip3,
            prop_val_mthd,
            prop_orig_hpi,
            prop_orig_val,

            borr_num,
            borr_dti,
            borr_orig_fico,
            borr_first_time_flg,

            rt_orig_mort15yr,
            rt_orig_mort30yr,
            rt_orig_mortarm5,
            rt_orig_treas10yr,
            rt_orig_libor12mo,
            rt_orig_libor1mo,
            rt_orig_libor3mo,

            monthly.dt,
            monthly.age,
            monthly.upb,
            monthly.ir,
            monthly.rem_term_legal,
            monthly.mat_dt,
            monthly.dq_status_cd,
            monthly.last_pay_dt,
            monthly.zb_cd,
            monthly.months_dq,

            monthly.mod_flg,
            monthly.borr_asst_plan,

            monthly.prop_hpi,
            monthly.prop_val,
            monthly.ln_ltv,
            monthly.ln_1stequity,
            monthly.rt_mort15yr,
            monthly.rt_mort30yr,
            monthly.rt_mortarm5,
            monthly.rt_treas10yr,
            monthly.rt_libor12mo,
            monthly.rt_libor1mo,
            monthly.rt_libor3mo,
            monthly.unemp_rate,

            mods.dt,
            mods.tot_loss,

            fc.dt,
            fc.cost,
            fc.pres_cost,
            fc.recov_cost,
            fc.misc_cost,
            fc.taxes,
            fc.net_prcds,
            fc.ce_prcds,
            fc.reprch_mw_prcds
        FROM
            freddie.final LIMIT 100)
    UNION ALL (
        SELECT
            harp_status,
            harp_ln_id,
            'fannie',

            ln_id,
            ln_bucket,
            vintage,
            src_file,
            slr_chan_cd,
            slr_name,
            arrayElement(monthly.serv_name, 1),

            last_dt,
            last_upb,
            last_dq_status_cd,
            last_zb_cd,
            last_months_dq,

            ln_orig_ir,
            ln_orig_prin,
            ln_orig_term,
            ln_fp_dt,
            ln_orig_ltv,
            ln_orig_cltv,
            ln_purp_cd,
            ln_mi_pct,
            ln_amort_cd,
            ln_pp_pen_flg,

            ln_zb_dt,
            ln_hrprog_flg,
            ln_dq_accr_int,
            ln_highbal_flg,
            ln_defrl_amt,

            prop_type_cd,
            prop_num_unit,
            prop_occ_cd,
            prop_st,
            prop_msa_cd,
            prop_zip3,
            prop_val_mthd,
            prop_orig_hpi,
            prop_orig_val,

            borr_num,
            borr_dti,
            borr_orig_fico,
            borr_first_time_flg,

            rt_orig_mort15yr,
            rt_orig_mort30yr,
            rt_orig_mortarm5,
            rt_orig_treas10yr,
            rt_orig_libor12mo,
            rt_orig_libor1mo,
            rt_orig_libor3mo,

            monthly.dt,
            monthly.age,
            monthly.upb,
            monthly.ir,
            monthly.rem_term_legal,
            monthly.mat_dt,
            monthly.dq_status_cd,
            monthly.last_pay_dt,
            monthly.zb_cd,
            monthly.months_dq,

            monthly.mod_flg,
            monthly.borr_asst_plan,

            monthly.prop_hpi,
            monthly.prop_val,
            monthly.ln_ltv,
            monthly.ln_1stequity,
            monthly.rt_mort15yr,
            monthly.rt_mort30yr,
            monthly.rt_mortarm5,
            monthly.rt_treas10yr,
            monthly.rt_libor12mo,
            monthly.rt_libor1mo,
            monthly.rt_libor3mo,
            monthly.unemp_rate,

            mods.dt,
            mods.tot_loss,

            fc.dt,
            fc.cost,
            fc.pres_cost,
            fc.recov_cost,
            fc.misc_cost,
            fc.taxes,
            fc.net_prcds,
            fc.ce_prcds,
            fc.reprch_mw_prcds
        FROM
            fannie.final LIMIT 100)



