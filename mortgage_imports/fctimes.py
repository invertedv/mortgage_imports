import pkg_resources
from muti import chu as cu
"""
Fannie Mae Foreclosure Timelines
will@invertedv.com

"""


def load_fctimes(data_loc, ip: str, user: str, pw: str):
    """
    :param data_loc: directory where the input files reside
    :param ip: IP address of Clickhouse
    :param user: Clickhouse user name
    :param pw: Clickhouse password
    """
    client = cu.make_connection(host=ip, user=user, password=pw)
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/fctimes') + '/'
    
    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"
    
    # create DB if not there
    cu.run_query("CREATE DATABASE IF NOT EXISTS aux", client)
    
    # rates that are recorded weekly
    cu.run_query("DROP TABLE IF EXISTS aux.fctimes", client)
    cu.run_query(sql_loc + "fctimes_ct.sql", client, True)
    cu.import_flat_file("aux.fctimes", data_loc + "fc_timelines.csv",delim=',',
                        format="CSV", host=ip, user=user, password=pw)
    
    client.disconnect()
