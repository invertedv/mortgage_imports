CREATE TABLE freddie.raw_orig
(
    borr_orig_fico      Int16,
    ln_fp_dt            FixedString(6),
    borr_first_time_flg LowCardinality(FixedString(1)),
    ln_mat_dt           FixedString(6),
    prop_msa_cd         LowCardinality(FixedString(5)), /* all blnk = not in MSA */
    ln_mi_pct           Float32,
    prop_num_unit       Int16,
    prop_occ_cd         LowCardinality(FixedString(1)), /* 9 = NA */
    ln_orig_cltv        Int16,
    borr_dti            Int16,
    ln_orig_prin        Float32,
    ln_orig_ltv         Int16,
    ln_orig_ir          Float32, /* rate or percentage? */
    slr_chan_cd         LowCardinality(FixedString(1)), /* t=unspecified TPO, 9=NA */
    ln_pp_pen_flg       LowCardinality(FixedString(1)),
    ln_amort_cd         LowCardinality(FixedString(5)), /* fannie is (3) */
    prop_st             LowCardinality(FixedString(2)),
    prop_type_cd        LowCardinality(FixedString(2)), /* 99 = NA */
    prop_zip3           LowCardinality(FixedString(5)), /* Fannie is (3) last 2 digits here are 00 */
    ln_id               String,
    ln_purp_cd          LowCardinality(FixedString(1)),
    ln_orig_term        Int16,
    borr_num            Int16,
    slr_name            LowCardinality(String),
    serv_name           LowCardinality(String),
    ln_highbal_flg      LowCardinality(FixedString(1)),
    ln_id_preharp       LowCardinality(String),
    ln_hrprog_flg       LowCardinality(FixedString(1)),
    ln_harp_flg         LowCardinality(FixedString(1)), /* NIF HARP indicator */
    prop_val_mthd       LowCardinality(FixedString(1)), /* Compare to Fannie */
    ln_io_flg           LowCardinality(FixedString(1)) /* NIF ARM IO indicator */
)
ENGINE = MergeTree()
ORDER BY (ln_id)
