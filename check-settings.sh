#!/usr/bin/env bash
SETTINGS=project-settings.bashrc
source $SETTINGS

green() {
    echo "\\033[0;32m$@\\033[0m"
}
orange() {
    echo "\\033[0;33m$@\\033[0m"
}
red() {
    echo "\\033[0;31m$@\\033[0m"
}
purple() {
    echo "\\033[0;35m$@\\033[0m"
}
gray() {
    echo "\\033[1;37m$@\\033[0m"
}

bold() {
    echo "\\033[1m$@\033[0m"
}

highlight_bold() {
    whole_str=$1
    highlight_str=$2
    echo ${whole_str/$highlight_str/$(bold $highlight_str)}
}

highlight_base() {
    echo $(highlight_bold $1 $(basename $1))
}

if [ -z "$PROJ_ROOT" ] # PROJ_ROOT is missing/not set
then
    echo "No value for PROJ_ROOT is set."
    echo "You should set it to the current directory by placing the following line at the top of $SETTINGS:"
    echo "PROJ_ROOT=\"$PWD\""
    exit 1

else # see if setting is an existing directory

    echo -ne "$(orange "checking\tPROJ_ROOT")\t$PROJ_ROOT: "
    if ! [ -e "$PROJ_ROOT" ]
    then # PROJ_ROOT is not there
        echo -e $(red no such directory.)
        echo "PROJ_ROOT is set to \"$PROJ_ROOT\" but it does not exist."
        echo "Check your settings in $SETTINGS and rerun this script."
        exit 1
    else # PROJ_ROOT is set correctly
        echo -e $(green exists.)

        # INPUTDIR  
        echo -ne "$(orange "checking\tINPUTDIR")\t$(highlight_base $INPUTDIR): "
        if [ -d "$INPUTDIR" ]
        then 
            echo -e $(green exists.)
        else
            echo -e $(red no such directory.)
            echo -e "$(purple Check your setting for INPUTDIR or create with \`mkdir -p \"$INPUTDIR\"\`)"
            exit 1
        fi

        # HISAT2PATH
        echo -ne "$(orange "checking\tHISAT2PATH")\t$(highlight_base $HISAT2PATH): "
        if [ -d "$HISAT2PATH" ]
        then
            echo -e $(green exists.)
        else
            echo -e $(red no such directory.)
            echo -e "$(purple Check your setting for HISAT2PATH or create with \`mkdir -p \"$HISAT2PATH\"\`)"
            exit 1
        fi
        
    fi
fi
