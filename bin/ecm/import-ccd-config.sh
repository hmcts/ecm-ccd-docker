#!/usr/bin/env bash

set -eu

if [ -z "$1" ]
then
    echo "Usage: ./import-ccd-config.sh [e|s|a]"
    exit 1
fi

if [ $1 = "e" ]
then
  echo "Importing EnglandWales config"
  if [[ -z "${ENGLANDWALES_CCD_CONFIG_PATH}" ]]
  then
    echo "Please set ENGLANDWALES_CCD_CONFIG_PATH"
    exit 1
  fi
  importFile="${ENGLANDWALES_CCD_CONFIG_PATH}/definitions/xlsx/et-englandwales-ccd-config-local.xlsx"
elif [ $1 = "s" ]
then
  echo "Importing Scotland config"
  if [[ -z "${SCOTLAND_CCD_CONFIG_PATH}" ]]
  then
    echo "Please set SCOTLAND_CCD_CONFIG_PATH"
    exit 1
  fi
  importFile="${SCOTLAND_CCD_CONFIG_PATH}/definitions/xlsx/et-scotland-ccd-config-local.xlsx"
else
  echo "Importing admin config"
  if [[ -z "${ADMIN_CCD_CONFIG_PATH}" ]]
  then
    echo "Please set ADMIN_CCD_CONFIG_PATH"
    exit 1
  fi
  importFile="${ADMIN_CCD_CONFIG_PATH}/definitions/xlsx/et-admin-ccd-config-local.xlsx"
fi

dir=$(dirname ${0})

${dir}/../ccd-import-definition.sh ${importFile}
