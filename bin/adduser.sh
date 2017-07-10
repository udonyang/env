#!/bin/bash

function main()
{
        local user=
        local needhelp=
        while getopts 'u:' opt; do
                case ${opt} in
                        u) user=${OPTARG};;
                        ?) needhelp=1;;
                esac
        done
        if [[ -z ${user} || -n ${needhelp} ]]; then
                echo "usage:"
                echo "  ${0} -u <username>"
                return -2
        fi
        if [[ -z $(cat /etc/passwd | grep ${user}) ]]; then
                adduser --home /home/${user} --shell /bin/bash --ingroup dev ${user}
        fi


        local home=/home/${user}

        local etc=${home}/etc
        mkdir -p ${home}/etc

        local tmp=${home}/tmp
        mkdir -p ${home}/tmp

        local nginxconf=${home}/etc/nginx.conf
        local index=${home}/index.html

        touch ${nginxconf} ${index}
        chown ${user}:dev ${etc} ${tmp} ${nginxconf} ${index}

        echo "server { server_name ${user}.com; error_log ${tmp}/nginx.error.log; access_log ${tmp}/nginx.access.log; root ${home}; index index.html;}" > ${nginxconf}
        echo "<html><head><title>${user}</title></head><body><p>Here is ${user}'s homepage.</p></body></html>" > ${index}
}

main ${*}
