#!/usr/bin/env bash
SETTINGS=project-settings.bashrc
source $SETTINGS

if [ -n "$PROJ_ROOT" ]
then
    if [ -e "$PROJ_ROOT" ]
    then # PROJ_ROOT is set correctly
        echo "yay PROJ_ROOT=$PROJ_ROOT"

        # INPUTDIR  
        echo -n "checking INPUTDIR \"$INPUTDIR\": "
        if [ -d "$INPUTDIR" ]
        then 
            echo "exists."
        else
            echo "no such directory."
            echo "create it with \`mkdir -p \"$INPUTDIR\"\`"
            exit 1
        fi

        # HISAT2PATH
        echo -n "checking HISAT2PATH \"$HISAT2PATH\": "
        if [ -d "$HISAT2PATH" ]
        then
            echo "exists."
        else
            echo "no such directory."
            echo "Check your setting for HISAT2PATH, or create with \`mkdir -p \"$HISAT2PATH\"\`"
            exit 1
        fi
        
        
    else # PROJ_ROOT is not there
        echo "PROJ_ROOT is set to \"$PROJ_ROOT\" but does not exist."
        echo "Check your settings in $SETTINGS and rerun this script."
    fi
else # PROJ_ROOT is missing
    echo "PROJ_ROOT is not set."
    echo "You should set it to the current directory by placing the following line at the top of $SETTINGS:"
    echo "PROJ_ROOT=\"$PWD\""
fi
