/*
  Foreclosure data

  taxes_reo: taxes as a % of prop_orig_val for REO disposition
  taxes_ss: taxes as a % of prop_orig_val for short sale disposition

  non_tax_costs_reo: all non-tax costs as a % of prop_orig_val for REO disposition
  non_tax_costs_ss: all non-tax costs as a % of prop_orig_val for short sale disposition

  fc_type: Judicial or Non-judicial
  fc_days: Fannie guideling for time to foreclose

 */
CREATE TABLE aux.fc_data
(
    prop_st                        LowCardinality(FixedString(2)),
    taxes_reo                      Float32,
    taxes_ss                       Float32,
    non_tax_costs_reo              Float32,
    non_tax_costs_ss               Float32,
    fc_type                        LowCardinality(String),
    fc_days                        Float32)
ENGINE = MergeTree()
ORDER BY (prop_st);
