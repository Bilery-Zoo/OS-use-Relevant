#!/usr/bin/env bash
# Author    : Bilery Zoo(bilery.zoo@gmail.com)
# create_ts : 2019-11-11
# program   : Search obj among docs under a directory


function search_obj_among_docs() {
    # Search obj among docs under a directory
        # $1: OS directory path
        # $2: Obj to search(pass to built-in `grep`)
    local path=$1
    local path=${path%/}
    local IFS=$'\n'
    # shellcheck disable=SC2045
    for doc in $(ls "${path}")
    do
        if [[ -d "${path}/${doc}" ]]; then
            search_obj_among_docs "${path}/${doc}" "$2"
        else
            # shellcheck disable=SC2002
            cat "${path}/${doc}" | grep "$2" &> /dev/null
            # shellcheck disable=SC2181
            if [[ $? -eq 0 ]]; then
                echo "${path}/${doc}"
            fi
        fi
    done
}


search_obj_among_docs "$1" "$2"
# To take a snack, execute the call below at your terminal:
# ./search_obj_among_docs.sh /etc UUID 2> /dev/null
