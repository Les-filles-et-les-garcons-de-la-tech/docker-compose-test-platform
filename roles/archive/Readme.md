# Archive (tar gz) list of files
From a list of files, will create an archive.
It will, modify *dst* fields of fact *filtered_paths* with correct destination name, specific for this operator/vendor.

## Inputs
|Variable Name|Description|Example|
|---|---|---|
|paths|List of files to archive.|["/ftp/client/TYPE2/PRV2TECHNO2/flat_file/A20220105.1045+0100-20220105.1100+0100_SubNetwork=RNC,SubNetwork=BHRNC04,MeContext=BHRNC04.gz", "/ftp/client/TYPE2/PRV2TECHNO2/flat_file/A20220105.1000+0100-20220105.1015+0100_SubNetwork=RNC,SubNetwork=BHRNC04,MeContext=BHRNC04.gz", "/ftp/client/TYPE2/PRV2TECHNO2/flat_file/A20220105.1030+0100-20220105.1045+0100_SubNetwork=RNC,SubNetwork=BHRNC04,MeContext=BHRNC04.gz"]|
|archive_name|Name of the archive to create.|/ftp/client/TYPE2/PRV2TECHNO2/flat_file/type2_provider2_techno2.20220105.10.tar.gz|

## Outputs
|Variable Name|Description|
|---|---|
|archive_stats|Stats, like size, of the newly created archive.|
