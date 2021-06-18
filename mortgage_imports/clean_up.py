import mortgage_imports.clickhouse_utilities as cu
import pkg_resources

def clean_up():
    client = cu.make_connection()
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/map') + '/'
    cu.run_query("DROP TABLE IF EXISTS map.zip3_st", client)
    cu.run_query(sql_loc + "zip3_st_ct.sql", client, True)
    cu.run_query(sql_loc + "zip3_st_ins.sql", client, True)

    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/fhfa') + '/'
    
    cu.run_query("DROP TABLE IF EXISTS fhfa.zip3_annotated", client)
    cu.run_query(sql_loc + "zip3_annotated_ct.sql", client, True)
    cu.run_query(sql_loc + "zip3_annotated_ins.sql", client, True)
    
    cu.run_query("DROP TABLE IF EXISTS fhfa.msad_annotated", client)
    cu.run_query(sql_loc + "msad_annotated_ct.sql", client, True)
    cu.run_query(sql_loc + "msad_annotated_ins.sql", client, True)
    
    cu.run_query("DROP TABLE IF EXISTS fhfa.state_annotated", client)
    cu.run_query(sql_loc + "state_annotated_ct.sql", client, True)
    cu.run_query(sql_loc + "state_annotated_ins.sql", client, True)
    
    cu.run_query("DROP TABLE IF EXISTS fhfa.state_non_msa_annotated", client)
    cu.run_query(sql_loc + "state_non_msa_annotated_ct.sql", client, True)
    cu.run_query(sql_loc + "state_non_msa_annotated_ins.sql", client, True)
    
    cu.run_query("DROP TABLE IF EXISTS fhfa.usa_annotated", client)
    cu.run_query(sql_loc + "usa_annotated_ct.sql", client, True)
    cu.run_query(sql_loc + "usa_annotated_ins.sql", client, True)
    
    client.disconnect()
