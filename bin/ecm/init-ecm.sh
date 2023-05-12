#!/usr/bin/env bash

set -eu
dir=$(dirname ${0})

${dir}/../add-users.sh
echo

${dir}/../add-ccd-roles.sh
echo

${dir}/../add-role-assignments.sh

if [[ ${ENGLANDWALES_CCD_CONFIG_PATH} ]]
then
  ${dir}/import-ccd-config.sh e
fi

if [[ ${SCOTLAND_CCD_CONFIG_PATH} ]]
then
  ${dir}/import-ccd-config.sh s
fi

if [[ ${ADMIN_CCD_CONFIG_PATH} ]]
then
  ${dir}/import-ccd-config.sh a
fi
