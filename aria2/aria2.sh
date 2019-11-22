#!/bin/bash

# aria2.sh and aria2.conf at the same dir.
PWD=$(cd `dirname $(readlink -f $0)`; pwd)

CONFIG_FILE=${PWD}/aria2.conf
SESSION_DIR=${HOME}/Downloads/aria2
SESSION_FILE=${SESSION_DIR}/.aria2.session

tcp_pid=0

function install_aria2()
{
    sudo apt-get install aria2 -y
}

function get_aria2_ports()
{
    data=`sudo lsof -i:6800 | grep aria2c`
    array=(${data// / })
    tcp_pid=${array[1]}
}

function kill_aria2_port()
{
    sudo kill -9 $1
}

function setup_aria2()
{
    # setup session dir.
    if [ ! -e ${SESSION_DIR} ]; then
        mkdir ${SESSION_DIR}
    fi
    if [ ! -e ${SESSION_FILE} ]; then
        touch ${SESSION_FILE}
    fi
}

function start_aria2()
{
    # setup aria2
    setup_aria2
    # start aria2
    aria2c --conf-path=${CONFIG_FILE}
}


function help_menu()
{
    echo "==============================================="
    echo "    aria2 command set"
    echo "==============================================="
    echo "-p"
    echo "  get  TCP port"
    echo "-k"
    echo "  kill TCP port"
    echo "-S"
    echo "  setup aria2"
    echo "-s"
    echo "  start aria2c"
}

if [ $# == 0 ]; then
    help_menu
else
    while getopts 'hpksS' opt
    do
        case $opt in
        h)
            help_menu
        ;;
        p)
            get_aria2_ports
        ;;
        k)
            get_aria2_ports
            if [ ${tcp_pid} != 0 ]; then
                kill_aria2_port ${tcp_pid}
            fi
        ;;
        s)
            start_aria2
        ;;
        S)
            setup_aria2
        ;;
        i)
            install_aria2
        ;;
        esac
    done
fi
