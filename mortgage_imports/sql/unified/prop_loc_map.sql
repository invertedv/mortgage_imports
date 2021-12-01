/*
 Find MSAs with fewer than 0.25% of loans
 Map these to the dominate state covered by the MSA
 */
WITH msa_by_st AS (
    SELECT
        prop_msa_cd,
        prop_st,
        count(*) AS n
    FROM
        unified.frannie
    WHERE prop_msa_cd != '00000'
    GROUP BY prop_msa_cd, prop_st
    ORDER BY prop_msa_cd, n DESC),
msa_st AS(
    SELECT
        prop_msa_cd,
        arrayElement(prop_st, 1) AS prop_st
    FROM (
        SELECT
            prop_msa_cd,
            groupArray(prop_st) AS prop_st,
            groupArray(n) AS n
        FROM msa_by_st
        GROUP BY prop_msa_cd)),
msa AS (
    SELECT
        prop_msa_cd,
        count(*) AS n,
        100 * count(*) / (SELECT count(*) FROM unified.frannie) AS pop_pct
    FROM
        unified.frannie
    GROUP BY prop_msa_cd
    HAVING pop_pct < 0.25)
SELECT
    a.*,
    b.prop_st AS prop_st
FROM
     msa AS a
JOIN
     msa_st AS b
USING prop_msa_cd
