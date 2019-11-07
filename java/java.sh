#!/bin/bash

AUTHOR="Byng Zeng"
VERSION="1.0.0"



function jdk_install() {
    sudo apt-get install openjdk-8-jdk -y
}


function print_help() {
    HELP_MENU=$(cat <<- EOF
	=======================================
	    java command set - $VERSION
	=======================================
	options:
	  -i | install : install jdk
	EOF
	)
    echo "$HELP_MENU"
}


if [ $# == 0 ]; then
    print_help
else
    while [ $# -gt 0 ]
    do
        case $1 in
        -i | install)
            shift
            jdk_install
            ;;
        *)
            print_help
            exit
        esac
    done
fi
