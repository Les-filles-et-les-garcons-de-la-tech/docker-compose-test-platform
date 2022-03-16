# Role used to find the files to copy
Setup a new list fact named filtered_paths containing at least 2 fields:
  * src: contains the path of the file to copy
  * dst: contains the new name and the file set in the *dst_path* folder

## Inputs
|Variable Name|Description|Example|
|---|---|---|
|dst_path|Intermediate path where the modified files are stored.|/tmp/home/orange_provider1_techno1/flat_file|
|filename_rename_regex|Regex to search for in the filenames to replace using *filename_replace_regex*|".*(A[\\d\\.-]+_BSC\\d+_[^\\.]+)\\.xml"|
|filename_replace_regex|Regex for file renaming.|"\\1BSC.xml"|
|file_list|List of found files.|["/ftp/client/TYPE2/PRV2TECHNO2/flat_file/A20220105.1045+0100-20220105.1100+0100_SubNetwork=RNC,SubNetwork=BHRNC04,MeContext=BHRNC04.gz", "/ftp/client/TYPE2/PRV2TECHNO2/flat_file/A20220105.1000+0100-20220105.1015+0100_SubNetwork=RNC,SubNetwork=BHRNC04,MeContext=BHRNC04.gz", "/ftp/client/TYPE2/PRV2TECHNO2/flat_file/A20220105.1030+0100-20220105.1045+0100_SubNetwork=RNC,SubNetwork=BHRNC04,MeContext=BHRNC04.gz"]|

Note about renaming: if no rename need to be done do not define either *filename_rename_regex* nor *filename_replace_regex*.

## Outputs
|Variable Name|Description|
|---|---|
|filtered_paths|List of dictionary with _name_, _src_, _dst_ & _checksum_ fields.|
