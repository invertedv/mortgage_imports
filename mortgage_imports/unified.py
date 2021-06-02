"""
 Build unified databaase of Freddie/Fannie loans
"""
import pkg_resources
import mortgage_imports.clickhouse_utilities as cu

def unify():

    client = cu.make_connection()
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/unified') + '/'
    
    cu.run_query("CREATE DATABASE IF NOT EXISTS unified", client)
    
    cu.run_query("DROP TABLE IF EXISTS unified.frannie", client)
    cu.run_query(sql_loc + "unified_ct.sql", client, True)
    cu.run_query(sql_loc + "unified_ins.sql", client, True)

