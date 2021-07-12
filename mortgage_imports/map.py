import pkg_resources
import mortgage_imports.clickhouse_utilities as cu
"""
Import tables that map zip codes to

- CBSA codes (zip_cbsa table)
- CBSA with division codes (zip_cbsad table)
- County codes (zip_cty table)

The first two tables include micropolitan mappings.
The table has all zip codes. A value of 00000 means the zip is not in a metro or micro area

The source of this data is [HUD](https://www.huduser.gov/portal/datasets/usps_crosswalk.html).

This depends on the fhfa.msad_map table to determine if a cbsad code is a metro or micro area

"""


def load_map(data_loc):
    client = cu.make_connection()
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/map') + '/'
    
    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"

    # create DB if not there
    cu.run_query("CREATE DATABASE IF NOT EXISTS map", client)

    # import table that maps from state postal name to fips ID
    cu.run_query("DROP TABLE IF EXISTS map.st_cd_raw", client)
    cu.run_query(sql_loc + "state_cd_raw_ct.sql", client, True)
    cu.import_flat_file("map.st_cd_raw", data_loc + "state.txt", delim="", format="TabSeparated")
    cu.run_query("DROP TABLE IF EXISTS map.st_cd", client)
    cu.run_query(sql_loc + "state_cd_ct.sql", client, True)
    cu.run_query(sql_loc + "state_cd_ins.sql", client, True)
    cu.run_query("DROP TABLE IF EXISTS map.st_cd_raw", client)

    # load the 5-digit zip to MSA (no divisions) map
    # If a zip is not in an MSA, the input has 99999 as the prop_msa_cd.  We change that to 00000
    # to be consistent with the Fannie data
    # The source file has a percentage of addresses that are residential in it, so we'll sort the array by
    # DECR by this value -- so picking array element 1 will give the county with the highest proportion of residences

    cu.run_query("DROP TABLE IF EXISTS map.zip_cbsa_raw", client)
    cu.run_query(sql_loc + "zip_cbsa_raw_ct.sql", client, True)
    cu.import_flat_file("map.zip_cbsa_raw", data_loc + "ZIP_CBSA_032021.csv", delim=",")

    cu.run_query("DROP TABLE IF EXISTS map.zip_cbsa", client)
    cu.run_query(sql_loc + "zip_cbsa_ct.sql", client, True)
    cu.run_query(sql_loc + "zip_cbsa_ins.sql", client, True)

    # load the 5-digit zip to MSA Division map
    # some zips cover 2 divisions, so after we read it in, we'll convert the prop_msad field to an array
    # The source file has a percentage of addresses that are residential in it, so we'll sort the array by
    # DECR by this value -- so picking array element 1 will give the div with the highest proportion of residences
    #
    # Note, the file has only zips within divisions, so we have to join to the msa table to get a global table
    cu.run_query("DROP TABLE IF EXISTS map.zip_cbsad_raw", client)
    cu.run_query(sql_loc + "zip_cbsad_raw_ct.sql", client, True)
    cu.import_flat_file("map.zip_cbsad_raw", data_loc + "ZIP_CBSA_DIV_032021.csv", delim=",")

    cu.run_query("DROP TABLE IF EXISTS map.zip_cbsad", client)
    cu.run_query(sql_loc + "zip_cbsad_ct.sql", client, True)
    cu.run_query(sql_loc + "zip_cbsad_ins.sql", client, True)
    cu.run_query("DROP TABLE IF EXISTS map.zip_cbsad_raw", client)
    cu.run_query("DROP TABLE IF EXISTS map.zip_cbsa_raw",client)

    # load the 5-digit zip to County map
    # some zips cover 2+ counties, so after we read it in, we'll convert the prop_cty_cd field to an array
    # The source file has a percentage of addresses that are residential in it, so we'll sort the array by
    # DECR by this value -- so picking array element 1 will give the county with the highest proportion of residences
    cu.run_query("DROP TABLE IF EXISTS map.zip_cty_raw", client)
    cu.run_query(sql_loc + "zip_cty_raw_ct.sql", client, True)
    cu.import_flat_file("map.zip_cty_raw", data_loc + "ZIP_COUNTY_122020.csv", delim=",")

    cu.run_query("DROP TABLE IF EXISTS map.zip_cty", client)
    cu.run_query(sql_loc + "zip_cty_ct.sql", client, True)
    cu.run_query(sql_loc + "zip_cty_ins.sql", client, True)
    cu.run_query("DROP TABLE IF EXISTS map.zip_cty_raw", client)

    cu.run_query("DROP TABLE IF EXISTS map.msad_geos", client)
    cu.run_query(sql_loc + "msad_geo_ct.sql", client, True)
    cu.run_query(sql_loc + "msad_geo_ins.sql", client, True)

    cu.run_query("DROP TABLE IF EXISTS map.msa_geos", client)
    cu.run_query(sql_loc + "msa_geo_ct.sql", client, True)
    cu.run_query(sql_loc + "msa_geo_ins.sql", client, True)

    client.disconnect()

