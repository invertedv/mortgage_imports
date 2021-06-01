import pkg_resources
import mortgage_imports.clickhouse_utilities as cu
import os
data_loc = '/mnt/driveb/freddie_data/'
filename = 'historical_data1_time_Q12017.txt'
#filename = 'tmp.txt'

client = cu.make_connection()
sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/freddie') + '/'

# add trailing / if needed
if data_loc[-1] != "/": data_loc += "/"

# create DB if not there
#cu.run_query("CREATE DATABASE IF NOT EXISTS freddie", client)

#cu.run_query("DROP TABLE IF EXISTS freddie.raw_perf", client)
#cu.run_query(sql_loc + "raw_perf_ct.sql", client, True)
#cu.import_flat_file("freddie.raw_perf", data_loc + filename)
filename = 'historical_data1_Q12017.txt'

#cu.run_query("DROP TABLE IF EXISTS freddie.raw_orig", client)
#cu.run_query(sql_loc + "raw_orig_ct.sql", client, True)
#cu.import_flat_file("freddie.raw_orig", data_loc + filename)

#cu.run_query("DROP TABLE IF EXISTS freddie.trans", client)
#cu.run_query(sql_loc + "transform_ct.sql", client, True)
#cu.run_query(sql_loc + "transform_ins.sql", client, True)

#cu.run_query("DROP TABLE IF EXISTS freddie.with_hpi", client)
#cu.run_query(sql_loc + "with_hpi_ct.sql", client, True)
#cu.run_query(sql_loc + "with_hpi_ins.sql", client, True)

src_file = 'HELLO'
#cu.run_query("DROP TABLE IF EXISTS freddie.n3sted", client)
#cu.run_query(sql_loc + "nested_ct.sql", client, True)
#cu.run_query(sql_loc + "nested_ins.sql", client, True, "XXXXXX", src_file)
first=True
if first:
    first = False
    cu.run_query("DROP TABLE IF EXISTS freddie.final", client)
    cu.run_query(sql_loc + "final_ct.sql", client, True)
cu.run_query(sql_loc + "final_ins.sql", client, True)
