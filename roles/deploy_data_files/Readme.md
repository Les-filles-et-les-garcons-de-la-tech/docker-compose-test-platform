# Deploy (copy) files to the host
Get *archive_name* from a source host (same name as running host replacing _dst by _src) and decompress it to *dst_path*.
Will use last host in *bastion* group to scp archive, therefore the order is important, the last bastion _must_ access the dst hosts directly.

## Inputs
|Variable Name|Description|Example|
|---|---|---|
|inventory_hostname|Destination host: Ansible variable of the host name where the files will be deployed. Must end with '_dst'|provider1_techno1_dst|
|inventory_hostname|Source hosts: Another host must be available with the same name except for the _dst replaced by _src|provider1_techno1_src|
|archive_name|Archive full name available on the source host.|/ftp/regusr/flat_file/type1_provider1_techno2.20211222.15.tgz|
|dst_path|Destination path where the files will be deployed.|/home/type1_provider1_techno1/flat_file|
