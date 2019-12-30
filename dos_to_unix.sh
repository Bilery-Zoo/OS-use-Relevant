#!/usr/bin/env bash
# Author    : Bilery Zoo(bilery.zoo@gmail.com)
# create_ts : 2019-06-06
# program   : Convert DOS/Mac text file format into Unix


function dos_to_unix() {
    # Convert DOS/Mac text file format into Unix under built-in `dos2unix` handler.
        # $1: OS directory path
    local path="$1"
    local path=${path%/}
    local IFS=$'\n'
    # shellcheck disable=SC2045
    for obj in $(ls "${path}")
    do
        if [[ -d "${path}/${obj}" ]]; then
            dos_to_unix "${path}/${obj}"
        else
            dos2unix "${path}/${obj}"
        fi
    done
}


dos_to_unix "$1"
