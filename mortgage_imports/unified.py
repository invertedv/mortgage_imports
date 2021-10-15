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

def backup(table, backup_table):
    from muti import chu
    client = chu.make_connection()
    qry = 'SHOW CREATE TABLE unified.{0}'.format(table)
    stmt = chu.run_query(qry, client, return_df=True).iloc[0]['statement']
    
    stmt = stmt.replace(table, backup_table)
    print(stmt)
    chu.run_query('DROP TABLE IF EXISTS unified.{0}'.format(backup_table), client)
    chu.run_query(stmt, client)
    qry = 'INSERT INTO unified.{0} SELECT * FROM unified.{1}'.format(backup_table, table)
    chu.run_query(qry, client)
    client.disconnect()
