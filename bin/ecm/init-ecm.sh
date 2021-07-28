#!/usr/bin/env bash

set -eu
dir=$(dirname ${0})

${dir}/../add-idam-clients.sh
${dir}/add-ecm-idam-roles.sh
${dir}/add-ecm-users.sh
${dir}/add-ecm-ccd-roles.sh