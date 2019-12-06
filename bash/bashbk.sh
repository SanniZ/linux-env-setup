#!/bin/bash

AUTHOR='Byng.Zeng'
VERSION=1.0.0


function backup_bash_files() {
    dst=$1
    if [ ! -e ${dst} ]; then  # create dst dir.
        mkdir -p ${dst}
    fi
    # copy files.
    for f in bash_aliases bash_exports 
    do
        cp -f ~/.${f} ${dst}/${f}
    done
}

function usage_help() {
    echo '========================================'
    echo "    bashbk - ${VERSION}"
    echo '========================================'
    echo 'Usage:   bashbk.sh option'
    echo ''
    echo 'option:'
    echo '  -b|bak|backup  path : path to save files.'
}


if [ $# == 0 ]; then
    usage_help
else
    while [ $# -gt 0 ]
    do
        case $1 in
        -b | bak | backup)  # backup.
            shift
            if [ $# -gt 0 ]; then
                backup_bash_files $@
                shift
            fi
        ;;
        *)
            usage_help
            exit
        ;;
        esac
    done
fi
