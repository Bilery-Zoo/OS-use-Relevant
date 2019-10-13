#!/usr/bin/env bash
# Author    : Bilery Zoo(652645572@qq.com)
# create_ts : 2019-10-01
# program   : Start &/ stop user-defined deamon service


service="/usr/bin/env python3 monitor.py"
pid_file=monitor.pid


function start() {
    # shellcheck disable=SC2154
    ${service} &
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        echo $! > ${pid_file}
    else exit 1
    fi
}


function stop() {
    # shellcheck disable=SC2046
    kill -9 $(cat ${pid_file})
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        rm -f ${pid_file}
    else exit 1
    fi
}


function call() {
    case $1 in
        'start')
            start
            ;;
        'stop')
            stop
            ;;
        *)
            # shellcheck disable=SC2016
            echo 'Get invalid option, please input(as to $1):'
            echo -e '\t"start" -> start service'
            echo -e '\t"stop"  -> stop service'
			exit 1
    esac
}


call "$1"
