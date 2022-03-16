# Copy and unarchive files inside the host
Copy *source_archive* to *archive_name* and untar them in *dst_path* directory.
*source_archive* can be a regex (.*\\\\.tar gz for example).

## Inputs
|Variable Name|Description|Example|
|---|---|---|
|archive_source_path|Full (absolute path) of the source archive|/ftp/client/TYPE2/PRV2TECHNO1/BSC_20220104500.tar.gz|
|source_archive|name of the source archive(s), list of regex can be given|/ftp/client/TYPE2/PRV2TECHNO1/BSC_20220104500.tar.gz|
|archive_name|Full (absolute path) name of the archive to deploy later|/ftp/client/TYPE2/PRV2TECHNO1/flat_file/type2_provider2_techno1.20220104.05.tgz|
|dst_path|Full (absolute path) where the files will be untar|/ftp/client/TYPE2/PRV2TECHNO1/flat_file/|

## Outputs

|Variable Name|Description|
|---|---|
|filtered_paths|List, absolute path and names, of untar files, should be *dst_path* + each file in *source_archive*|
