#!/bin/bash

AUTHOR="Byng Zeng"
VERSION="1.0.0"

VIMDIR=~/.vim
VIMRC=~/.vimrc

ctags=ctags-5.8
ctagstargz=$ctags.tar.gz
taglist=taglist_46.zip

function vim_install() {
    sudo apt-get install vim -y
}


function vim_config() {
    # create .vimrc
    if [ ! -e $VIMRC ]; then
        touch $VIMRC
    fi

    echo 'set nu' >> $VIMRC
	echo 'set history=100' >> $VIMRC
	echo 'set clipboard+=unnamed' >> $VIMRC
	echo 'syntax on' >> $VIMRC
	echo 'setlocal noswapfile' >> $VIMRC
	echo 'set bufhidden=hide' >> $VIMRC
	echo 'set ruler' >> $VIMRC
	echo 'set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)' >> $VIMRC
	echo 'set mouse=a' >> $VIMRC
	echo 'set selection=exclusive' >> $VIMRC
	echo 'set selectmode=mouse,key' >> $VIMRC
	echo 'set showmatch' >> $VIMRC
	# echo 'set smartindent' >> $VIMRC
	echo 'autocmd BufNewFile,BufRead *.html,*.htm,*.css,*.js set noexpandtab tabstop=2 shiftwidth=2' >> $VIMRC
	echo 'autocmd BufNewFile,BufRead *.py,*.sh set expandtab tabstop=4 shiftwidth=4' >> $VIMRC

	echo 'nmap sp :split<cr>' >> $VIMRC
	echo 'nmap vp :vsplit<cr>' >> $VIMRC
}


function vim_install_ctags_taglist() {
    if [ ! -d $VIMDIR ]; then
        mkdir $VIMDIR
    fi

    # copy source files.
    cp plugin/$ctagstargz $VIMDIR
    cp plugin/$taglist $VIMDIR

    cur=$(pwd)

    # install taglist
    cd $VIMDIR
    unzip $taglist

    # install ctags
    tar xvf $ctagstargz
    echo 'let Tlist_Show_One_File=1' >> $VIMRC
    echo 'let Tlist_Exit_OnlyWindow=1' >> $VIMRC
    echo 'nmap tl :Tlist<cr>' >> $VIMRC
    echo 'set tags=$PWD/tags' >> $VIMRC

    # install ctags
    cd $ctags
    ./configure
    make
    make install

    # clean
    cd $VIMDIR
    rm -rf $ctags $ctagstargz
    rm -rf $taglist

    cd $cur
}



function print_help() {
    HELP_MENU=$(cat <<- EOF
	=======================================
	    vim command set - $VERSION
	=======================================
	options:
	  -i | install : install vim
	  -c | config  : config vim
	  -t | tag     : install ctags and taglist
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
            vim_install
            ;;
        -c | config)
            shift
            vim_config
            ;;
        -t | tag)
            shift
            vim_install_ctags_taglist
            ;;
        *)
            print_help
            exit
        esac
    done
fi
