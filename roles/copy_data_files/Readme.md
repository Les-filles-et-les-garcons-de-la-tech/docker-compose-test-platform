# Copy files inside the host
Will create a script on the host to copy (and rename) files inside the host. If needed it gunzip the files.

## Inputs
|Variable Name|Description|Example|
|---|---|---|
|copy_dst_path|Where to copy the files on the host|/tmp/home/type1_provider1_techno1/flat_file|
|files_to_copy|List of 2 fields named *src* & *dst*, will copy src file to dst, both src & dst are path/name.ext|[{"dst": "/path/from/file.csv", "src": "/path/to/newname.csv"}]|
|copy_script_name|Full path + name of the temporary copy script on the control node|/tmp/type1_provider2_techno1_src.20211222.08.sh|
|script_path|Destination path on the host of the copy script |/ftp/arpt/flat_file/|
