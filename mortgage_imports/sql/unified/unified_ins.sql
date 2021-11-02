/*
 Insert the union of Freddie and Fannie data

 monthly.mod_sticky_flg has 'Y' always after the first 'Y'. Fannie updates this monthly. Freddie only flags 'Y'
 on the month of the modification.

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
            slr_name = '' OR startsWith(slr_name, 'other') ? 'other' : slr_name AS slr_name,
            serv_name = '' OR startsWith(serv_name, 'other') ? 'other' : serv_name AS serv_name,

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
            ln_purp_cd = 'N' ? 'R' : ln_purp_cd,
            ln_mi_pct,
            ln_amort_cd,
            ln_pp_pen_flg,

            'N' AS ln_nonstd_doc_flg,
            'N' AS ln_nonstd_uw_flg,
            'N' AS ln_govt_guar_flg,
            'N' AS ln_negam_flg,

            ln_zb_dt,
            ln_hrprog_flg = '9' ? 'N' : ln_hrprog_flg,
            ln_dq_accr_int,
            ln_highbal_flg,

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
            /*indexOf(monthly.mod_flg, 'Y') AS first_mod_index,*/
           /* Freddie also includes a value of P for Prior mod */
           CASE
             WHEN indexOf(monthly.mod_flg, 'Y') > 0 AND indexOf(monthly.mod_flg, 'P') > 0 AND indexOf(monthly.mod_flg, 'Y') < indexOf(monthly.mod_flg, 'P') THEN indexOf(monthly.mod_flg, 'Y')
             WHEN indexOf(monthly.mod_flg, 'Y') > 0 AND indexOf(monthly.mod_flg, 'P') > 0 AND indexOf(monthly.mod_flg, 'Y') > indexOf(monthly.mod_flg, 'P') THEN indexOf(monthly.mod_flg, 'P')
             WHEN indexOf(monthly.mod_flg, 'P') > 0 THEN indexOf(monthly.mod_flg, 'P')
             ELSE indexOf(monthly.mod_flg, 'Y')
           END AS first_mod_index,

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
            first_mod_index > 0 ?
                arrayConcat(arraySlice(monthly.mod_flg, 1, first_mod_index-1),
                    arrayMap(x -> 'Y' , arraySlice(monthly.mod_flg, first_mod_index))) :
                    monthly.mod_flg AS mod_sticky_flg,
            monthly.borr_asst_plan,
            monthly.defrl_amt,

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
            /* Freddie has costs as negative */
            arrayMap(x -> -x, fc.cost),
            arrayMap(x -> -x, fc.pres_cost),
            arrayMap(x -> -x, fc.recov_cost),
            arrayMap(x -> -x, fc.misc_cost),
            arrayMap(x -> -x, fc.taxes),
            fc.net_prcds,
            fc.ce_prcds,
            fc.reprch_mw_prcds
        FROM
            freddie.final)
    UNION ALL (
        SELECT
            harp_status,
            harp_ln_id,
            concat('fannie:', src_data),

            ln_id,
            ln_bucket,
            vintage,
            src_file,
            slr_chan_cd,

            slr_name = '' OR startsWith(slr_name, 'other') ? 'other' : slr_name AS slr_name,

            arrayFirst(x -> x = '' ? 0 : 1, arrayReverse(monthly.serv_name)) = '' OR
                startsWith( arrayFirst(x -> x = '' ? 0 : 1, arrayReverse(monthly.serv_name)), 'other') ?
                'other' :  arrayFirst(x -> x = '' ? 0 : 1, arrayReverse(monthly.serv_name)) AS serv_name,
            /* freddie value is the servicer on last month, fannie has a value for each month
            multiIf(arrayElement(monthly.serv_name, -1) = '', 'other',
                position(arrayElement(monthly.serv_name, -1), 'other servicers') > 0, 'other',
                arrayElement(monthly.serv_name, -1)) AS serv_name,*/

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

            ln_nonstd_doc_flg,
            ln_nonstd_uw_flg,
            ln_govt_guar_flg,
            ln_negam_flg,

            ln_zb_dt,
            ln_hrprog_flg,
            ln_dq_accr_int,
            ln_highbal_flg,

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
            indexOf(monthly.mod_flg, 'Y') AS first_mod_index,

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
            /* if flag is ! call it N */
            first_mod_index > 0 ?
                arrayConcat(arrayMap(x -> x = '!' ? 'N': x, arraySlice(monthly.mod_flg, 1, first_mod_index)),
                    arrayMap(x -> 'Y' , arraySlice(monthly.mod_flg, first_mod_index+1))) :
                    arrayMap(x -> x = '!' ? 'N' : x, monthly.mod_flg) AS mod_sticky_flg,
            monthly.borr_asst_plan,
            monthly.defrl_amt,

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
            fannie.final)



