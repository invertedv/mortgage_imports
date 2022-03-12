import pkg_resources
from muti import chu as cu
"""

First off: unemployment rates

The msa data is from [here](https://download.bls.gov/pub/time.series/la/la.data.60.Metro)

The division data is from [here](https://download.bls.gov/pub/time.series/la/la.data.62.Micro)

The state data is from [here](https://download.bls.gov/pub/time.series/la/la.data.3.AllStatesS)

- Delete the top row (headers)
- run fromdos on the file to drop <CR> from the file
"""


def load_econ(data_loc, ip: str, user: str, pw: str):
    """
    :param data_loc: directory where the input files reside
    :param ip: IP address of Clickhouse
    :param user: Clickhouse user name
    :param pw: Clickhouse password
    """
    client = cu.make_connection(host=ip, user=user, password=pw)
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/econ') + '/'
    
    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"

    # create DB if not there
    cu.run_query("CREATE DATABASE IF NOT EXISTS econ", client)

    # Load up msa-level data
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msa_raw", client)
    cu.run_query(sql_loc + "unemp_raw_ct.sql", client, is_file=True,
                 replace_source="XXXXX", replace_dest="unemp_msa_raw")
    cu.import_flat_file("econ.unemp_msa_raw", data_loc + "la.data.60.Metro.txt", format="TabSeparated",
                        host=ip, user=user, password=pw)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msa", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ"],
                replace_dest=["unemp_msa", "prop_msa_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_ins.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZ"],
                 replace_dest=["unemp_msa", "substr(id, 8, 5)", "AND substr(id, 3, 1) != 'S'"])
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msa_raw", client)
    
    # Load up msa division data (this is *only* divisions)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad0_raw", client)
    cu.run_query(sql_loc + "unemp_raw_ct.sql", client, True, replace_source= "XXXXX", replace_dest="unemp_msad0_raw")
    cu.import_flat_file("econ.unemp_msad0_raw", data_loc + "la.data.61.Division.txt", format="TabSeparated",
                        host=ip, user=user, password=pw)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad0", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ"],
              replace_dest=["unemp_msad0", "prop_msad_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_ins.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZ"],
                 replace_dest=["unemp_msad0", "substr(id, 8, 5)", "AND substr(id, 3, 1) != 'S'"])
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad0_raw", client)
    
    # the above is ONLY divisions -- so we need to add the MSAs that don't have divisions
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ"],
              replace_dest=["unemp_msad", "prop_msad_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_msad_ins.sql", client, True)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad0", client)

    # Load up micro-politan areas
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_micro_raw", client)
    cu.run_query(sql_loc + "unemp_raw_ct.sql", client, True, replace_source="XXXXX", replace_dest="unemp_micro_raw")
    cu.import_flat_file("econ.unemp_micro_raw", data_loc + "la.data.62.Micro.txt", format="TabSeparated",
                        host=ip, user=user, password=pw)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_micro", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ"],
              replace_dest=["unemp_micro", "prop_micro_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_ins.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZ"],
                 replace_dest=["unemp_micro", "substr(id, 8, 5)", "AND substr(id, 3, 1) != 'S'"])
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_micro_raw", client)

    # Load up state-level data
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state0_raw", client)
    cu.run_query(sql_loc + "unemp_raw_ct.sql", client, True, replace_source="XXXXX", replace_dest="unemp_state0_raw")
    cu.import_flat_file("econ.unemp_state0_raw", data_loc + "la.data.3.AllStatesS.txt", format="TabSeparated",
                        host=ip, user=user, password=pw)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state0", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ"],
              replace_dest=["unemp_state0", "prop_st_cd", "LowCardinality(FixedString(2))"])
    cu.run_query(sql_loc + "unemp_ins.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZ"],
                 replace_dest=["unemp_state0", "substr(id, 6, 2)", ""])
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state0_raw", client)

    # fold in the state postal code
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state", client)
    cu.run_query(sql_loc + "unemp_final_ct.sql", client, True)
    cu.run_query(sql_loc + "unemp_final_ins.sql", client, True)
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state0", client)

    # Create CBSA table by combining MSA table and micro table
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_cbsa", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ"],
              replace_dest=["unemp_cbsa", "prop_cbsa_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_cbsa_ins.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ", "TTTTT"],
              replace_dest=["unemp_cbsa", "prop_cbsa_cd", "prop_msa_cd", "econ.unemp_msa"])
    
    # Create CBSAD table by combining MSAD table and micro table
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_cbsad", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ"],
              replace_dest=["unemp_cbsad", "prop_cbsad_cd", "LowCardinality(FixedString(5))"])
    cu.run_query(sql_loc + "unemp_cbsa_ins.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ", "TTTTT"],
              replace_dest=["unemp_cbsad", "prop_cbsad_cd", "prop_msad_cd", "econ.unemp_msad"])

    # usa values
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_usa_raw", client)
    cu.run_query(sql_loc + "unemp_usa_raw_ct.sql", client, True, replace_source="XXXXX", replace_dest="unemp_usa_raw")
    cu.import_flat_file("econ.unemp_usa_raw", data_loc + "us.csv", delim=',', host=ip, user=user, password=pw)

    cu.run_query("DROP TABLE IF EXISTS econ.unemp_usa", client)
    cu.run_query(sql_loc + "unemp_ct.sql", client, True, replace_source=["XXXXX", "YYYYY", "ZZZZZ"],
                 replace_dest=["unemp_usa", "prop_ctry_cd", "LowCardinality(FixedString(3))"])
    cu.run_query(sql_loc + "unemp_usa_ins.sql", client, True, replace_source=["XXXX"],
                 replace_dest=["unemp_usa"])
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_usa_raw", client)

    client.disconnect()
