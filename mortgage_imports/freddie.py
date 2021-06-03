import pkg_resources
import mortgage_imports.clickhouse_utilities as cu
import os

def load_freddie(data_loc, build_final):

    client = cu.make_connection()
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/freddie') + '/'
    
    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"

    flist = os.listdir(data_loc)

    # need to know if this is the first time through the loop
    first = True
    # file count
    fn = 0

    if not build_final:
        cu.run_query("DROP TABLE IF EXISTS freddie.n3sted", client)
        cu.run_query(sql_loc + "nested_ct.sql", client, True)

    # we want the HARP file to be the first file read (it's the biggest so thought we'd start there)
    for filename in sorted(flist):
        if filename.find('time') < 0 and filename.find('historical') == 0 and filename.find('.txt') > 0:
            print('working on {0}'.format(filename))
            if filename.find('excl') > 0:
                parts = filename.split('data_excl')
                perf_file = parts[0] + 'data_excl_time' + parts[1]
            else:
                parts = filename.split('data')
                perf_file = parts[0] + 'data_time' + parts[1]

            # create DB if not there
            cu.run_query("CREATE DATABASE IF NOT EXISTS freddie", client)
    
            cu.run_query("DROP TABLE IF EXISTS freddie.raw_perf", client)
            cu.run_query(sql_loc + "raw_perf_ct.sql", client, True)
            cu.import_flat_file("freddie.raw_perf", data_loc + perf_file, options='--input_format_allow_errors_num=20')
            
            cu.run_query("DROP TABLE IF EXISTS freddie.raw_orig", client)
            cu.run_query(sql_loc + "raw_orig_ct.sql", client, True)
            cu.import_flat_file("freddie.raw_orig", data_loc + filename,  options='--input_format_allow_errors_num=20')
            
            cu.run_query("DROP TABLE IF EXISTS freddie.trans", client)
            cu.run_query(sql_loc + "transform_ct.sql", client, True)
            cu.run_query(sql_loc + "transform_ins.sql", client, True)
            cu.run_query("DROP TABLE IF EXISTS freddie.raw_orig", client)
            cu.run_query("DROP TABLE IF EXISTS freddie.raw_perf", client)

            cu.run_query("DROP TABLE IF EXISTS freddie.with_hpi", client)
            cu.run_query(sql_loc + "with_hpi_ct.sql", client, True)
            cu.run_query(sql_loc + "with_hpi_ins.sql", client, True)
            cu.run_query("DROP TABLE IF EXISTS freddie.trans", client)

            src_file = filename[0:filename.find(".")]
            cu.run_query(sql_loc + "nested_ins.sql", client, True, "XXXXXX", src_file)

            print('done: {0}'.format(filename))
            fn += 1
    
    if build_final:
        cu.run_query("DROP TABLE IF EXISTS freddie.final", client)
        cu.run_query(sql_loc + "final_ct.sql", client, True)
        cu.run_query(sql_loc + "final_ins.sql", client, True)
    print("Processed {0} files".format(fn))
    client.disconnect()

