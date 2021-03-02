import pkg_resources
import mortgage_imports.clickhouse_utilities as cu
"""

First off: unemployment rates

The msa data is from [here](https://download.bls.gov/pub/time.series/la/la.data.60.Metro)

The division data is from [here](https://download.bls.gov/pub/time.series/la/la.data.62.Micro)

The state data is from [here](https://download.bls.gov/pub/time.series/la/la.data.3.AllStatesS)

- Delete the top row (headers)
- run fromdos on the file to drop <CR> from the file
"""


def load_econ(data_loc):
    client = cu.make_connection()
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/econ') + '/'
    
    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"

    # Load up msa-level data
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msa_raw", client)
    cu.run_query(sql_loc + "unemp_raw_ct.sql", client, True, "XXXXX", "unemp_msa_raw")
    cu.import_flat_file("econ.unemp_msa_raw", data_loc + "la.data.60.Metro", format="TabSeparated")
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msa", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, ["XXXXX", "YYYYY", "ZZZZZ"],
              ["unemp_msa", "prop_msa_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_ins.sql", client, True, ["XXXXX", "YYYYY"], ["unemp_msa", "substr(id, 8, 5)"])
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msa_raw", client)
    
    # Load up msa division data (this is *only* divisions)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad0_raw", client)
    cu.run_query(sql_loc + "unemp_raw_ct.sql", client, True, "XXXXX", "unemp_msad0_raw")
    cu.import_flat_file("econ.unemp_msad0_raw", data_loc + "la.data.61.Division", format="TabSeparated")
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad0", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, ["XXXXX", "YYYYY", "ZZZZZ"],
              ["unemp_msad0", "prop_msad_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_ins.sql", client, True, ["XXXXX", "YYYYY"], ["unemp_msad0", "substr(id, 8, 5)"])
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad0_raw", client)
    
    # the above is ONLY divisions -- so we need to add the MSAs that don't have divisions
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, ["XXXXX", "YYYYY", "ZZZZZ"],
              ["unemp_msad", "prop_msad_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_msad_ins.sql", client, True)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad0", client)

    # Load up micro-politan areas
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_micro_raw", client)
    cu.run_query(sql_loc + "unemp_raw_ct.sql", client, True, "XXXXX", "unemp_micro_raw")
    cu.import_flat_file("econ.unemp_micro_raw", data_loc + "la.data.62.Micro", format="TabSeparated")
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_micro", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, ["XXXXX", "YYYYY", "ZZZZZ"],
              ["unemp_micro", "prop_micro_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_ins.sql", client, True, ["XXXXX", "YYYYY"], ["unemp_micro", "substr(id, 8, 5)"])
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_micro_raw", client)

    # Load up state-level data
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state0_raw", client)
    cu.run_query(sql_loc + "unemp_raw_ct.sql", client, True, "XXXXX", "unemp_state0_raw")
    cu.import_flat_file("econ.unemp_state0_raw", data_loc + "la.data.3.AllStatesS", format="TabSeparated")
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state0", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, ["XXXXX", "YYYYY", "ZZZZZ"],
              ["unemp_state0", "prop_st_cd", "LowCardinality(FixedString(2))"])
    cu.run_query(sql_loc + "unemp_ins.sql", client, True, ["XXXXX", "YYYYY"], ["unemp_state0", "substr(id, 6, 2)"])
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state0_raw", client)

    # fold in the state postal code
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state", client)
    cu.run_query(sql_loc + "unemp_final_ct.sql", client, True)
    cu.run_query(sql_loc + "unemp_final_ins.sql", client, True)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state0", client)

    # Create CBSA table by combining MSA table and micro table
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_cbsa", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, ["XXXXX", "YYYYY", "ZZZZZ"],
              ["unemp_cbsa", "prop_cbsa_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_cbsa_ins.sql", client, True, ["XXXXX", "YYYYY", "ZZZZZ", "TTTTT"],
              ["unemp_cbsa", "prop_cbsa_cd", "prop_msa_cd", "econ.unemp_msa"])
    
    # Create CBSAD table by combining MSAD table and micro table
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_cbsad", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, ["XXXXX", "YYYYY", "ZZZZZ"],
              ["unemp_cbsad", "prop_cbsad_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_cbsa_ins.sql", client, True, ["XXXXX", "YYYYY", "ZZZZZ", "TTTTT"],
              ["unemp_cbsad", "prop_cbsad_cd", "prop_msad_cd", "econ.unemp_msad"])

