import pkg_resources
#import mortgage_imports.clickhouse_utilities as cu
from muti import chu as cu
import os

def load_fannie(data_loc: str, src: str, first: bool, ip: str, user: str, pw: str):
    """
    :param data_loc: directory where the input files reside
    :param src: either 'harp_map' or 'standard' to select type of files to import
    :param first: if True, creates a new 'final' table
    :param ip: IP address of Clickhouse
    :param user: Clickhouse user name
    :param pw: Clickhouse password
    """
    client = cu.make_connection(host=ip, user=user, password=pw)
    sql_loc = pkg_resources.resource_filename('mortgage_imports', 'sql/fannie') + '/'
    
    # add trailing / if needed
    if data_loc[-1] != "/": data_loc += "/"

    # create DB if not there
    cu.run_query("CREATE DATABASE IF NOT EXISTS fannie", client)

    if src == 'harp_map':
        # load harp_map table which maps non-harp loans to their harp refis
        cu.run_query("DROP TABLE IF EXISTS fannie.harp_map", client)
        cu.run_query(sql_loc + "harp_map_ct.sql", client, True)
        cu.import_flat_file("fannie.harp_map", data_loc + "Loan_Mapping.txt",
                            delim=",", host=ip, user=user, password=pw)
        return
    elif src == 'standard':
        extra_fields=''
        extra_field_ins = """
            'N' AS ln_nonstd_doc_flg,
            'N' AS ln_nonstd_uw_flg,
            'N' AS ln_govt_guar_flg,
            'N' AS ln_negam_flg
        """
    else:
        extra_fields = """
           ,ln_nonstd_doc_flg                 LowCardinality(FixedString(1)),
            ln_nonstd_uw_flg                  LowCardinality(FixedString(1)),
            ln_govt_guar_flg                  LowCardinality(FixedString(1)),
            ln_negam_flg                      LowCardinality(FixedString(1))
        """
        extra_field_ins = """
            ln_nonstd_doc_flg,
            ln_nonstd_uw_flg,
            ln_govt_guar_flg,
            ln_negam_flg
        """

    # files in the data directory
    flist = os.listdir(data_loc)

    # need to know if this is the first time through the loop
    # file count
    fn = 0

    # we want the HARP file to be the first file read (it's the biggest so thought we'd start there)
    for filename in sorted(flist, reverse=True):
        if (filename[0] == "2") or (filename == "HARPLPPub.csv"):
            print("working on {0}".format(filename))
            src_file = filename[0:filename.find(".")]
            cu.run_query("DROP TABLE IF EXISTS fannie.raw", client)
            cu.run_query(sql_loc + "raw_ct.sql", client, True,
                         replace_source=['<extra_fields>'],
                         replace_dest=[extra_fields])
            cu.import_flat_file("fannie.raw", data_loc + filename, host=ip, user=user, password=pw)
        
            cu.run_query("DROP TABLE IF EXISTS fannie.trans", client)
            cu.run_query(sql_loc + "transform_ct.sql", client, True)
            cu.run_query(sql_loc + "transform_ins.sql", client, True,
                         replace_source=['<src>', '<extra_field_ins>'],
                         replace_dest=[src, extra_field_ins])
            cu.run_query("DROP TABLE IF EXISTS fannie.raw", client)
        
            cu.run_query("DROP TABLE IF EXISTS fannie.with_hpi", client)
            cu.run_query(sql_loc + "with_hpi_ct.sql", client, True)
            cu.run_query(sql_loc + "with_hpi_ins.sql", client, True)
            cu.run_query("DROP TABLE IF EXISTS fannie.trans", client)
        
            cu.run_query("DROP TABLE IF EXISTS fannie.n3sted", client)
            cu.run_query(sql_loc + "nested_ct.sql", client, True)
            cu.run_query(sql_loc + "nested_ins.sql", client, True, replace_source='<src_file>',
                         replace_dest=src_file)
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
    client.disconnect()

