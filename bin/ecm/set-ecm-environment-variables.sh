#!/bin/bash

function set_env_variables() {
    set_env_variables_from_file "./ecm-environment-variables.txt"
}

function set_env_variables_from_file() {
    file=$1
    if [ -f ${file} ]
    then
        osName="$(uname -s)"
        echo "Setting ECM env variables from [$file] on [$osName]."
        while IFS="=" read -r key value
        do
            if [[ "Darwin" == "$osName" ]];then
                command="export $key=$value"
                $command
            else
                setx "$key" $(echo $value | sed -e 's/\r//g')
            fi
        done < "$file"
    else
        echo "ECM Environment variable file : $file NOT found. Variables NOT set."
    fi
}

originDir=$PWD
cd ./bin/ecm
set_env_variables
cd "$originDir"
