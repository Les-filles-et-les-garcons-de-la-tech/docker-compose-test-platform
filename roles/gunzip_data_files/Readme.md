# Copy files inside the host
Will create a script on the host to gunzip files inside the host.

## Inputs
|Variable Name|Description|Example|
|---|---|---|
|copy_dst_path|Where to copy the files on the host|/tmp/home/type2_provider1_techno1/flat_file|
|files_to_expand|List of file names to gunzip|["/path/from/file.csv.gz", "/path/to/file2.csv"]|
|expand_script_name|Full path + name of the temporary script on the control node|/tmp/type1_zte_techno1_src.20211222.08.sh|
|script_path|Destination path on the host of the script |/ftp/regusr/flat_file/|

## Outputs

|Variable Name|Description|Example|
|---|---|---|
|files_to_expand|Same list, without without *gz* extension|["/path/from/file.csv", "/path/to/file2.csv"]|