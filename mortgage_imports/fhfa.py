import pkg_resources
import mortgage_imports.clickhouse_utilities as cu
"""
Import the FHFA house price indices (HPI).

The following tables are created

- msad            HPI at the MSA division level
- state           HPI at the state level
- state_not_msa   HPI at state level excluding MSA divisions
- zip3            HPI at the 3-digit zip level
- msad_map        map of CBSA MSA+Division codes to names

source: fhfa.gov
"""

def load_fhfa(data_loc):
    
    client = cu.make_connection()
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/fhfa') + '/'

    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"

    # create DB if not there
    cu.run_query("CREATE DATABASE IF NOT EXISTS fhfa", client)

    # load the State HPI table
    cu.run_query("DROP TABLE IF EXISTS fhfa.state", client)
    cu.run_query(sql_loc + "state_ct.sql", client, True)
    cu.import_flat_file("fhfa.state", data_loc + "HPI_AT_state.csv", delim=",")
    
    # load the msad HPI table
    cu.run_query("DROP TABLE IF EXISTS fhfa.msad", client)
    cu.run_query(sql_loc + "msad_ct.sql", client, True)
    cu.import_flat_file("fhfa.msad", data_loc + "HPI_AT_metro.csv", delim=",")
    cu.run_query("ALTER TABLE fhfa.msad UPDATE fhfa_msad = NULL WHERE fhfa_msad = 0", client)
    cu.run_query("ALTER TABLE fhfa.msad UPDATE delta = NULL WHERE delta = 0", client)

    # Build MSA map
    cu.run_query("DROP TABLE IF EXISTS fhfa.msad_map", client)
    cu.run_query(sql_loc + "msad_map_ct.sql", client, True)
    cu.run_query(sql_loc + "msad_map_ins.sql", client, True)

    # load the 'State but not in MSA' HPI table
    cu.run_query("DROP TABLE IF EXISTS fhfa.state_non_msa", client)
    cu.run_query(sql_loc + "state_non_msa_ct.sql", client, True)
    cu.import_flat_file("fhfa.state_non_msa", data_loc + "HPI_AT_nonmetro.csv", delim=",")

    # load the ZIP-3 HPI table
    cu.run_query("DROP TABLE IF EXISTS fhfa.zip3", client)
    cu.run_query(sql_loc + "zip3_ct.sql", client, True)
    cu.import_flat_file("fhfa.zip3", data_loc + "HPI_AT_3zip.csv", delim=",")
    
    # load the usa table
    cu.run_query("DROP TABLE IF EXISTS fhfa.usa", client)
    cu.run_query(sql_loc + "usa_ct.sql", client, True)
    cu.import_flat_file("fhfa.usa", data_loc + "longer_HPI_EXP_us_nsa.csv", delim=",")

    client.disconnect()


