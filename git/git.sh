#!/bin/bash

AUTHOR="Byng Zeng"
VERSION="1.0.0"



function git_install() {
    sudo apt-get install git -y    
}


function git_config_user_name() {
    if [ $1 == --global ]; then
        git config --global user.name $2
    else
        git config user.name $1
    fi
}


function git_config_user_email() {
    if [ $1 == --global ]; then
        git config --global user.email $2
    else
        git config user.email $1
    fi
}

function print_help() {
    HELP_MENU=$(cat <<- EOF
	=======================================
	    git command set - $VERSION
	=======================================
	options:
	  -i | install : install git
      -e | email   : config current user.email
      -E | Email   : config global user.email
      -n | name    : config current  user.name
      -N | Name    : config global user.name
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
            git_install
            ;;
        -e | email)
            shift
            git_config_user_email $@
            shift
            ;;
        -E | Email)
            shift
            git_config_user_email --global $@
            shift
            ;;
        -n | name)
            shift
            git_config_user_name $@
            shift
            ;;

        -N | Name)
            shift
            git_config_user_name --global $@
            shift
            ;;
        *)
            print_help
            exit
        esac
    done
fi
