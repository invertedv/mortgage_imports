/*
 creates tables of foreclosure costs


 */
INSERT INTO aux.fc_data
WITH fc AS (
    SELECT
        ln_id,
        ln_mi_pct,
        src_data,
        prop_orig_val,
        prop_st,
        last_zb_cd,
        length(fc.dt) AS l,
        arrayElement(fc.dt, l) AS dt,
        arrayElement(fc.cost, l) AS cost,
        arrayElement(fc.pres_cost, l) AS pres_cost,
        arrayElement(fc.recov_cost, l) AS recov_cost,
        arrayElement(fc.misc_cost, l) AS misc_cost,
        arrayElement(fc.taxes, l) AS taxes,
        arrayElement(fc.net_prcds, l) AS net_prcds,
        arrayElement(fc.ce_prcds, l) AS ce_prcds,
        arrayElement(fc.reprch_mw_prcds, l) AS reprch_mw_prcds,
        arrayMin(arrayFilter(x -> x > 1000 ? 1 : 0, monthly.upb)) AS last_upb,
        arrayMax(monthly.months_dq) AS max_dq1,
        arrayElement(monthly.months_dq, length(monthly.dt) - 1) AS max_dq,
        ln_orig_ir * max_dq * last_upb / 1200.0 AS lost_interest,
        net_prcds - taxes - cost - pres_cost - recov_cost - misc_cost - lost_interest AS net_cash,
        last_upb - net_cash AS raw_loss,
        toInt16(max_dq / 12.0) * 12 + 24 AS dq,
        arrayMax(monthly.age) < dq ? arrayMax(monthly.age) : dq AS taxdq,
        taxdq > 0 ? taxes * 12 / dq : -1 AS annual_tax_reo,
        max_dq > 0 ? taxes * 12 / dq : -1 AS annual_tax_short,
        cost + pres_cost + recov_cost + misc_cost AS nontax_costs
    FROM
        unified.frannie
    WHERE last_zb_cd in ('03', '09')
),
mi AS (
    /* checks the average actual coverage versus the MI coverage level */
    SELECT
        ln_mi_pct,
        avg(net_prcds) AS anet_prcds,
        avg(taxes + cost + pres_cost + recov_cost + misc_cost) AS acost,
        avg(lost_interest) AS alost_interest,
        avg(ce_prcds) AS ace_prcds,
        avg(last_upb) AS alast_upb,
        avg(net_cash) AS anet_cash,
        avg(raw_loss) AS araw_loss,
        ace_prcds / araw_loss AS pct_covered,
        count(*) as n
    FROM
        fc
    WHERE ln_mi_pct in (6, 16, 18, 40, 17, 12, 20, 35, 30, 25) AND ce_prcds >= 0
    GROUP BY ln_mi_pct
    ORDER BY ln_mi_pct),
cost_rates AS (
    SELECT
        prop_st,
        last_zb_cd = '03' ? 1: 0 AS short_sale,
        100 * sum(taxes) / sum(prop_orig_val) AS tax_rate,
        100 * sum(nontax_costs) / sum(prop_orig_val) AS nontax_cost_rate
    FROM
        fc
    WHERE prop_orig_val > 0
    GROUP BY prop_st, short_sale
    ORDER BY prop_st, short_sale),
cost_table AS (
    SELECT
        prop_st,
        arrayElement(tax_rate, 1) AS tax_rate_reo,
        arrayElement(tax_rate, 2) AS tax_rate_ss,
        arrayElement(nontax_cost_rate, 1) AS nontax_cost_rate_reo,
        arrayElement(nontax_cost_rate, 2) AS nontax_cost_rate_ss
    FROM (
        SELECT
            prop_st,
            groupArray(short_sale) AS short_sale,
            groupArray(tax_rate) AS tax_rate,
            groupArray(nontax_cost_rate) AS nontax_cost_rate
        FROM
          cost_rates
        GROUP BY prop_st
        ORDER BY prop_st))
SELECT
    c.prop_st,
    c.tax_rate_reo,
    c.tax_rate_ss,
    c.nontax_cost_rate_reo,
    c.nontax_cost_rate_ss,
    x.fc_type,
    x.fc_days
FROM
    cost_table AS c
JOIN
    aux.fctimes AS x
ON
    c.prop_st = x.prop_st

