# Role used to find the files to copy
It will, according to the filter day *filter_day* & path *gather_filters*.

## Inputs
|Variable Name|Description|Example|
|---|---|---|
|gather_source_path|Source path from where the files will be copied.|/ftp/arpt/DATA|
|gather_filters|Regex Fitechno2r to apply to source files to narrow the copy to the relevant ones.|".*A[\\d\\.-]+\_BSC\\d+\_[^\\.]+\\.xml"|
|exclude_filters|Regex filter for files to exclude.|".*MSC.*"|

Note about renaming: if no rename need to be done do not define either *filename_rename_regex* nor *filename_replace_regex*.

## Outputs
|Variable Name|Description|Example|
|---|---|---|
|filtered_files|List of found files.|{'files': ["/ftp/client/TYPE2/PRV2TECHNO2/flat_file/A20220105.1045+0100-20220105.1100+0100_SubNetwork=RNC,SubNetwork=BHRNC04,MeContext=BHRNC04.gz", "/ftp/client/TYPE2/PRV2TECHNO2/flat_file/A20220105.1000+0100-20220105.1015+0100_SubNetwork=RNC,SubNetwork=BHRNC04,MeContext=BHRNC04.gz", "/ftp/client/TYPE2/PRV2TECHNO2/flat_file/A20220105.1030+0100-20220105.1045+0100_SubNetwork=RNC,SubNetwork=BHRNC04,MeContext=BHRNC04.gz"]}|
