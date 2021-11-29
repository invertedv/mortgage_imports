INSERT INTO unified.slr_map
WITH dur AS (
    SELECT
        slr_mapper(slr_name) AS slr_name_mapped,
        count(*) AS n,
        sum(dateDiff('month', ln_fp_dt, coalesce(ln_zb_dt, toDate('1970-01-01'))) > 0 AND dateDiff('month', ln_fp_dt, coalesce(ln_zb_dt, toDate('1970-01-01'))) <= 36 ? 1: 0) / n AS ppr
    FROM
        unified.frannie
    GROUP BY slr_name_mapped),
quans AS (
    SELECT
        quantilesExactWeighted(0.25, 0.5, 0.75)(ppr, n) AS qs
    FROM
        dur),
grps AS (
SELECT
    slr_name_mapped,
    (SELECT * FROM quans) AS quan,
    n,
    ppr,
    CASE
        WHEN ppr < arrayElement(quan, 1) THEN 'group1'
        WHEN ppr < arrayElement(quan, 2) THEN 'group2'
        WHEN ppr < arrayElement(quan, 3) THEN 'group3'
        ELSE 'group4'
    END AS group
FROM dur)
SELECT
    a.slr_name,
    a.slr_name_mapped,
    grps.group AS pp_group,
    grps.ppr AS pp_rate,
    grps.n AS nloans,
    100 * grps.n / (SELECT count(*) FROM unified.frannie) AS pop_pct
FROM (
    SELECT
        distinct slr_name,
        slr_mapper(slr_name) AS slr_name_mapped
    FROM
        unified.frannie) AS a
JOIN
    grps
ON
    grps.slr_name_mapped = a.slr_name_mapped


