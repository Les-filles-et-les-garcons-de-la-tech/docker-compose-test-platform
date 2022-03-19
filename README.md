# Workflows
## Main
 1. Get available files from SSH server: role [gather_data_files](roles/gather_data_files/Readme.md).
    * Optionally run complex actions to reformat destination names, example: role [force_title_case](roles/force_title_case/Readme.md).
 1. Internal treatment used to format the destination name according to input regex: role [format_data_filenames](roles/format_data_filenames/Readme.md).
 1. Copy these files with the target name, according to a client classification, inside the SSH server: role [copy_data_files](roles/copy_data_files/Readme.md).
    * This role will automatically gunzip each file ending with _.gz_.
 1. Archiving the gathered files: role [archive](roles/archive/Readme.md).
 1. Copy them to the TRA server: role [deploy_data_files](roles/deploy_data_files/Readme.md).

The first 3 actions are done using the playbook [get_files](get_files_simple_bastion.yml)

## Audit
 1. Get last 2 days files from SSH servers.
 1. Compress these files to a dedicated server and path.

## Tests
Build & run the mock infra, see [setup_infra.sh](testsplatform/simple_bastion/setup_infra.sh), example for simple_bastion:
```bash
SERVER=simple_bastion
./testsplatform/setup_infra.sh ${SERVER}
. ./testsplatform/.dev.env
docker run --rm --name ansible_$SERVER --network=${SERVER}_external_network -v $PWD:/playbooks ${REGISTRY}ansible:$STABLE_VERSION -i /playbooks/$SERVER/$SERVER.yml /playbooks/get_files_$SERVER.yml
docker run --rm --name ansible_$SERVER --network=${SERVER}_external_network -v $PWD:/playbooks/ ${REGISTRY}ansible:$STABLE_VERSION -i /playbooks/$SERVER/$SERVER.yml /playbooks/deploy_files.yml
```
Optionally launch only Cellcom operator for a specific day/hour:
```bash
SERVER=simple_bastion
PROCESS_DAY=20211213
PROCESS_HOUR=11
TYPE=type3
. ./testsplatform/.dev.env
docker run --rm --name ansible_$SERVER --network=${SERVER}_external_network -v $PWD:/playbooks ${REGISTRY}ansible:$STABLE_VERSION -i /playbooks/$SERVER/$SERVER.yml -e "filter_day=$PROCESS_DAY" -e filter_hour=$PROCESS_HOUR -l $TYPE /playbooks/get_files_$SERVER.yml
docker run --rm --name ansible_$SERVER --network=${SERVER}_external_network -v $PWD:/playbooks/ ${REGISTRY}ansible:$STABLE_VERSION -i /playbooks/$SERVER/$SERVER.yml -e "filter_day=$PROCESS_DAY" -e filter_hour=$PROCESS_HOUR -l $TYPE /playbooks/deploy_files.yml
```

# Next Steps
* Refactor & merge Dockerfiles by country:
  * app_servers are almost identical
  * ssh_src_server differs on script to launch
