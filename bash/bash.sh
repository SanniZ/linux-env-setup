#!/bin/bash

AUTHOR="Byng Zeng"
VERSION="1.0.0"

BASH_ALIASES=~/bash_aliases
BASHRC=~/bashrc

function config_bash_aliases() {
    if [ ! -e $BASH_ALIASES ]; then
        touch $BASH_ALIASES
    fi

    echo '# alias for path' >> $BASH_ALIASES
    echo 'alias cdb="cd -"' >> $BASH_ALIASES
    echo 'alias cdu="cd .."' >> $BASH_ALIASES
    echo 'alias cdl="cd ~/Downloads"' >> $BASH_ALIASES
    echo 'alias cdc="cd ~/Documents"' >> $BASH_ALIASES
    echo 'alias cws="cd $WS"' >> $BASH_ALIASES
    echo 'alias cgit="cd $GIT"' >> $BASH_ALIASES
    echo 'alias cpy="cd $MYPY"' >> $BASH_ALIASES
    echo 'alias csh="cd $MYSH"' >> $BASH_ALIASES
    echo 'alias cbin="cd $HBIN"' >> $BASH_ALIASES
    echo 'alias csh="cd $MYSH"' >> $BASH_ALIASES
    echo 'alias cbin="cd $HBIN"' >> $BASH_ALIASES
    echo '' >> $BASH_ALIASES
    echo '# alias for git' >> $BASH_ALIASES
    echo 'alias gst="git status"' >> $BASH_ALIASES
    echo 'alias gdf="git diff"' >> $BASH_ALIASES
    echo 'alias gaa="git add"' >> $BASH_ALIASES
    echo 'alias gbr="git branch"' >> $BASH_ALIASES
    echo 'alias gbra="git branch -a"' >> $BASH_ALIASES
    echo 'alias gcm="git commit -m"' >> $BASH_ALIASES
    echo 'alias gca="git commit --amend"' >> $BASH_ALIASES
    echo 'alias gfp="git format-patch"' >> $BASH_ALIASES
    echo 'alias gfph="git format-patch HEAD~"' >> $BASH_ALIASES
    echo 'alias glg="git log"' >> $BASH_ALIASES
    echo 'alias gsw="git show"' >> $BASH_ALIASES
    echo 'alias gsp='git show -p'' >> $BASH_ALIASES
    echo 'alias gpm='git push origin master'' >> $BASH_ALIASES
    echo '' >> $BASH_ALIASES
    echo '# alias for python' >> $BASH_ALIASES
    echo 'alias iba="ibus.py -a"' >> $BASH_ALIASES
    echo 'alias ibu="ibus.py -u"' >> $BASH_ALIASES
    echo 'alias ibr="ibus.py -r"' >> $BASH_ALIASES
    echo 'alias ibs="ibus.py -s"' >> $BASH_ALIASES
    echo '' >> $BASH_ALIASES
    echo '# alias for others' >> $BASH_ALIASES
    echo 'alias cpyc="find . -name __pycache__ | xargs rm -rf"' >> $BASH_ALIASES
}

function config_bash_export() {
    if [ ! -e $BASHRC ]; then
        touch $BASHRC
    fi

    echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64' >> $BASHRC
    echo 'export JRE_HOME=$JAVA_HOME/jre' >> $BASHRC
    echo 'export CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH' >> $BASHRC
    echo 'export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin' >> $BASHRC
    echo 'export HBIN=~/bin' >> $BASHRC
    echo 'export HBINPY=$HBIN/py' >> $BASHRC
    echo 'export HBINSH=$HBIN/sh' >> $BASHRC
    echo 'export WS=~/workspace' >> $BASHRC
    echo 'export GIT=~/.mygit' >> $BASHRC
    echo 'export IBUS=$GIT/IBus' >> $BASHRC
    echo 'export MYPY=$GIT/mypy' >> $BASHRC
    echo 'export MYSH=$GIT/mysh' >> $BASHRC
    echo '' >> $BASHRC
    echo 'export MYPATHS=$HBIN:$HBINPY:$HBINSH:$MYPY:$WS' >> $BASHRC
    echo '' >> $BASHRC
    echo 'export PYTHONPATH=$PYTHONPATH:$MYPY' >> $BASHRC
    echo '' >> $BASHRC
    echo 'export PATH=$PATH:$MYPATHS' >> $BASHRC
}

function print_help() {
	HELP_MENU=$(cat <<- EOF
	=======================================
	    bash command set - $VERSION
	=======================================
	options:
	  -a | aliases : config bash aliases
	  -e | export  : config export
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
        -a | aliases)
            shift
            config_bash_aliases
            ;;
        -e | expend)
            shift
            config_bash_export
            ;;
        *)
            print_help
            exit
        esac
    done
fi

