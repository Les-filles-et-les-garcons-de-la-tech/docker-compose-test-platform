#!/usr/bin/env bash

TEST_PATH="$(dirname $0)"

function help
{
    echo "usage: $0 server"
    echo '       server: the server to process'
    echo ''
    echo 'Will build and launch the test platform of the corresponding server.'
    echo "directory ${TEST_PATH}/${SERVER} must exists and contains the docker-compose file."

    exit 1
}

[[ "$1" == "" ]] && help || export SERVER=$1

[[ -d "${TEST_PATH}/${SERVER}" ]] || help

KEY_NAME="id_rsa"
TODAY=$(date '+%Y%m%d')
ENV_FILE="${TEST_PATH}/.dev.env"
grep -q TO_DATE ${ENV_FILE} \
    && sed -i "s/_DATE=.*/_DATE=${TODAY}/" ${ENV_FILE} \
    || echo -e "TO_DATE=${TODAY}\nFROM_DATE=${TODAY}" >> ${ENV_FILE}
source ${ENV_FILE}

echo n | ssh-keygen -b 2048 -t rsa -q -P "" -f ${TEST_PATH}/ssh_server/${KEY_NAME} &> /dev/null ; cp -u ${TEST_PATH}/ssh_server/${KEY_NAME}* ${TEST_PATH}/ansible

set -e

docker build --build-arg VERSION=16.04 -t ${REGISTRY}ssh_ubuntu_16:${STABLE_VERSION} ${TEST_PATH}/ssh_server
docker build --build-arg VERSION=18.04 -t ${REGISTRY}ssh_ubuntu_18:${STABLE_VERSION} ${TEST_PATH}/ssh_server
docker build --build-arg VERSION=3.15.0 -t ${REGISTRY}ansible:${STABLE_VERSION} ${TEST_PATH}/ansible
docker compose --project-directory "${TEST_PATH}/${SERVER}" --env-file ${ENV_FILE} build
docker compose --project-directory "${TEST_PATH}/${SERVER}" --env-file ${ENV_FILE} up -d --wait
