#!/bin/bash

function main()
{
        local needhelp=
        local root=
        local log=/tmp/$(basename ${0})
        while getopts 'r:' opt; do
                case ${opt} in
                        r) root=${OPTARG};;
                        ?) needhelp=1;;
                esac
        done
        if [[ -n ${needhelp} || -z ${root} ]]; then
                echo "usage: ${0} -r <root>"
                return -2
        fi

        local files=$(find ${root} -type f -name nginx.conf)
        ps aux | grep inotifywait | grep nginx.conf | grep -v grep | awk '{print $2}' | xargs kill -9 
        nohup inotifywait -me move_self ${files} | 
        while read file sig; do
                echo "- $(date) - ${file} ${sig}"
                /usr/sbin/nginx -s reload
        done > ${log} 2>&1&
}

main ${*}
