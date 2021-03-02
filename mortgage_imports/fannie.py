import pkg_resources
import mortgage_imports.clickhouse_utilities as cu
import os

def load_fannie(data_loc):
    client = cu.make_connection()
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/fannie') + '/'
    
    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"

    # load harp_map table which maps non-harp loans to their harp refis
    cu.run_query("DROP TABLE IF EXISTS fannie.harp_map", client)
    cu.run_query(sql_loc + "harp_map_ct.sql", client, True)
    cu.import_flat_file("fannie.harp_map", data_loc + "Loan_Mapping.txt", delim=",")

    flist = os.listdir(data_loc)
    # Loop throught the files

    # need to know if this is the first time through the loop
    first = True
    # file count
    fn = 0

    # we want the HARP file to be the first file read (it's the biggest so thought we'd start there)
    for filename in sorted(flist, reverse=True):
        if (filename[0] == "2") or (filename == "HARPLPPub.csv"):
            print("working on {0}".format(filename))
            src_file = filename[0:filename.find(".")]
            cu.run_query("DROP TABLE IF EXISTS fannie.raw", client)
            cu.run_query(sql_loc + "raw_ct.sql", client, True)
            cu.import_flat_file("fannie.raw", data_loc + filename)
        
            cu.run_query("DROP TABLE IF EXISTS fannie.trans", client)
            cu.run_query(sql_loc + "transform_ct.sql", client, True)
            cu.run_query(sql_loc + "transform_ins.sql", client, True)
            cu.run_query("DROP TABLE IF EXISTS fannie.raw", client)
        
            cu.run_query("DROP TABLE IF EXISTS fannie.with_hpi", client)
            cu.run_query(sql_loc + "with_hpi_ct.sql", client, True)
            cu.run_query(sql_loc + "with_hpi_ins.sql", client, True)
            cu.run_query("DROP TABLE IF EXISTS fannie.trans", client)
        
            cu.run_query("DROP TABLE IF EXISTS fannie.n3sted", client)
            cu.run_query(sql_loc + "nested_ct.sql", client, True)
            cu.run_query(sql_loc + "nested_ins.sql", client, True, "XXXXXX", src_file)
            cu.run_query("DROP TABLE IF EXISTS fannie.with_hpi", client)
            if first:
                first = False
                cu.run_query("DROP TABLE IF EXISTS fannie.final", client)
                cu.run_query(sql_loc + "final_ct.sql", client, True)
            cu.run_query(sql_loc + "final_ins.sql", client, True)
            cu.run_query("DROP TABLE IF EXISTS fannie.n3sted", client)
            print("done: {0}".format(filename))
        fn += 1

    print("Processed {0} files".format(fn))

