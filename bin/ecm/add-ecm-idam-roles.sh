#!/usr/bin/env bash

set -eu
dir=$(dirname ${0})
echo "$dir"
jq -c '(.[])' ${dir}/roles.json | while read args; do
  role=$(jq -r '.role' <<< $args)
  ${dir}/../utils/idam-add-role.sh $role
done
