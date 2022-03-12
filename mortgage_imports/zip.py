import pkg_resources
from muti import chu as cu
"""
Import tables that zip code files that include latitude and longitude


The source of this data is [here](http://download.geonames.org/export/zip/).
See [here](https://www.geonames.org)

"""


def load_zip(data_loc, ip: str, user: str, pw: str):
    """
    :param data_loc: directory where the input files reside
    :param ip: IP address of Clickhouse
    :param user: Clickhouse user name
    :param pw: Clickhouse password
    """
    client = cu.make_connection(host=ip, user=user, password=pw)
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/zip') + '/'
    # create DB if not there
    cu.run_query("CREATE DATABASE IF NOT EXISTS zip", client)

    # import table that maps from state postal name to fips ID
    cu.run_query("DROP TABLE IF EXISTS zip.zip5", client)
    cu.run_query(sql_loc + "zip5_ct.sql", client, True)
    cu.import_flat_file("zip.zip5", data_loc + "/US.txt", delim="", format="TabSeparated",
                        host=ip, user=user, password=pw)

    # import table that maps from state postal name to fips ID
    cu.run_query("DROP TABLE IF EXISTS zip.zip3", client)
    cu.run_query(sql_loc + "zip3_ct.sql", client, True)
    cu.run_query(sql_loc + 'zip3_ins.sql', client, True)


