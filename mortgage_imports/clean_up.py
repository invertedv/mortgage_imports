from muti import chu as cu
import pkg_resources

def clean_up(ip: str, user: str, pw: str):
    """
    :param ip: IP address of Clickhouse
    :param user: Clickhouse user name
    :param pw: Clickhouse password
    """
    client = cu.make_connection(host=ip, user=user, password=pw)
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/unified') + '/'

    qry = 'DROP TABLE IF EXISTS aux.fc_data'
    cu.run_query(qry, client)

    cu.run_query(sql_loc + 'fc_data_ct.sql', client, is_file=True)
    cu.run_query(sql_loc + 'fc_data_ins.sql', client, is_file=True)

    cu.run_query('DROP FUNCTION IF EXISTS prop_loc_mapper', client)
    df = cu.run_query(sql_loc + 'prop_loc_map.sql', client, True, return_df=True)
    map = ''
    for j in range(df.shape[0]):
        msa = df.iloc[j]['prop_msa_cd']
        st = df.iloc[j]['prop_st']
        map += "    WHEN msa = '{0}' THEN '{1}' \n".format(msa, st)
    map += "    WHEN msa = '00000' THEN st"
    map += '    ELSE msa'
    cu.run_query(sql_loc + 'prop_loc_function.sql', client, True, replace_dest=[map], replace_source=['<maps>'])

    cu.run_query('DROP FUNCTION IF EXISTS serv_mapper', client)
    cu.run_query(sql_loc + 'serv_function.sql', client, True)
    
    cu.run_query('DROP TABLE IF EXISTS unified.serv_map', client)
    cu.run_query(sql_loc + 'serv_map_ct.sql', client, True)
    cu.run_query(sql_loc + 'serv_map_ins.sql', client, True)

    cu.run_query('DROP FUNCTION IF EXISTS slr_mapper', client)
    cu.run_query(sql_loc + 'slr_function.sql', client, True)

    cu.run_query('DROP TABLE IF EXISTS unified.slr_map', client)
    cu.run_query(sql_loc + 'slr_map_ct.sql', client, True)
    cu.run_query(sql_loc + 'slr_map_ins.sql', client, True)

    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/map') + '/'
    
    cu.run_query("DROP TABLE IF EXISTS map.zip3_st", client)
    cu.run_query(sql_loc + "zip3_st_ct.sql", client, True)
    cu.run_query(sql_loc + "zip3_st_ins.sql", client, True)

    # Annotated tables
    # hpi
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

    # econ
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/econ') + '/'
    
    cu.run_query("DROP TABLE IF EXISTS econ.unemp_state_annotated", client)
    cu.run_query(sql_loc + "unemp_st_annotated_ct.sql", client, True)
    cu.run_query(sql_loc + "unemp_st_annotated_ins.sql", client, True)

    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msa_annotated", client)
    cu.run_query(sql_loc + "unemp_msa_annotated_ct.sql", client, True)
    cu.run_query(sql_loc + "unemp_msa_annotated_ins.sql", client, True)

    cu.run_query("DROP TABLE IF EXISTS econ.unemp_msad_annotated", client)
    cu.run_query(sql_loc + "unemp_msad_annotated_ct.sql", client, True)
    cu.run_query(sql_loc + "unemp_msad_annotated_ins.sql", client, True)

    cu.run_query("DROP TABLE IF EXISTS econ.unemp_usa_annotated", client)
    cu.run_query(sql_loc + "unemp_usa_annotated_ct.sql", client, True)
    cu.run_query(sql_loc + "unemp_usa_annotated_ins.sql", client, True)

    client.disconnect()
