import pkg_resources
from muti import chu as cu
"""
FRED II data
will@invertedv.com
2 data series, based on frequency of data update

"""


def load_rates(data_loc, ip: str, user: str, pw: str):
    """
    :param data_loc: directory where the input files reside
    :param ip: IP address of Clickhouse
    :param user: Clickhouse user name
    :param pw: Clickhouse password
    """
    client = cu.make_connection(host=ip, user=user, password=pw)
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/rates') + '/'
    
    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"

    # create DB if not there
    cu.run_query("CREATE DATABASE IF NOT EXISTS rates", client)

    # rates that are recorded weekly
    cu.run_query("DROP TABLE IF EXISTS rates.weekly_raw", client)
    cu.run_query(sql_loc + "weekly_raw_ct.sql", client, True)
    cu.import_flat_file("rates.weekly_raw", data_loc + "Weekly_Rates_Weekly_Ending_Thursday.txt",
                        format="TabSeparated", host=ip, user=user, password=pw)
    
    # rates that are recorded daily
    cu.run_query("DROP TABLE IF EXISTS rates.daily_raw", client)
    cu.run_query(sql_loc + "daily_raw_ct.sql", client, True)
    cu.import_flat_file("rates.daily_raw", data_loc + "Daily_Rates_Daily.txt",
                        format="TabSeparated", host=ip, user=user, password=pw)

    # make table of monthly average rates
    cu.run_query("DROP TABLE IF EXISTS rates.monthly", client)
    cu.run_query(sql_loc + "joined_ct.sql", client, True)
    cu.run_query(sql_loc + "joined_ins.sql", client, True)

    client.disconnect()