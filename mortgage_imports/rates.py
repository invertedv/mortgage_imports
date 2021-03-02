import pkg_resources
import mortgage_imports.clickhouse_utilities as cu
"""
FRED II data
will@invertedv.com
2 data series, based on frequency of data update

"""


def load_econ(data_loc):
    client = cu.make_connection()
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/rates') + '/'
    
    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"

    # rates that are recorded weekly
    cu.run_query("DROP TABLE IF EXISTS rates.weekly_raw", client)
    cu.run_query(sql_loc + "weekly_raw_ct.sql", client, True)
    cu.import_flat_file("rates.weekly_raw", data_loc + "Weekly_Rates_Weekly_Ending_Thursday.txt",
                        format="TabSeparated")
    
    # rates that are recorded daily
    cu.run_query("DROP TABLE IF EXISTS rates.daily_raw", client)
    cu.run_query(sql_loc + "daily_raw_ct.sql", client, True)
    cu.import_flat_file("rates.daily_raw", data_loc + "Daily_Rates_Daily.txt",
                        format="TabSeparated")

    # make table of monthly average rates
    cu.run_query("DROP TABLE IF EXISTS rates.monthly", client)
    cu.run_query(sql_loc + "joined_ct.sql", client, True)
    cu.run_query(sql_loc + "joined_ins.sql", client, True)


load_econ("/mnt/driveb/rates_data")