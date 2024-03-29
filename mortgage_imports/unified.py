"""
 Build unified databaase of Freddie/Fannie loans
"""
import pkg_resources
from muti import chu as cu

def unify(ip: str, user: str, pw: str):
    """
    :param ip: IP address of Clickhouse
    :param user: Clickhouse user name
    :param pw: Clickhouse password
    """

    client = cu.make_connection(host=ip, user=user, password=pw)
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/unified') + '/'
    
    cu.run_query("CREATE DATABASE IF NOT EXISTS unified", client)
    
    cu.run_query("DROP TABLE IF EXISTS unified.frannie", client)
    cu.run_query(sql_loc + "unified_ct.sql", client, True)
    cu.run_query(sql_loc + "unified_ins.sql", client, True)
    client.disconnect()

def backup(table, backup_table, ip: str, user: str, pw: str):
    from muti import chu
    client = chu.make_connection(host=ip, user=user, password=pw)
    qry = 'SHOW CREATE TABLE unified.{0}'.format(table)
    stmt = chu.run_query(qry, client, return_df=True).iloc[0]['statement']
    
    stmt = stmt.replace(table, backup_table)
    print(stmt)
    chu.run_query('DROP TABLE IF EXISTS unified.{0}'.format(backup_table), client)
    chu.run_query(stmt, client)
    qry = 'INSERT INTO unified.{0} SELECT * FROM unified.{1}'.format(backup_table, table)
    chu.run_query(qry, client)
    client.disconnect()
