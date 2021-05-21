#!/bin/bash

if [ $1 ]; then
    if [ $1 = "c" ]; then
        if [ $2 ] && [ $2 = "-r" ]; then
            if [ $3 ]; then
                if [ -e $3 ] && [ $3 ]; then
                    if [ $4 ]; then
                        dir=$4
                    else
                        dir="./$(basename $3 .c)"
                    fi
                    gcc $3 -o "$dir"
                    ./"$(basename $3 .c)"
                else
                    echo "$3 is not an existing file."
                fi
            else
                echo "Please select the file to compile and run."
            fi
        elif [ -e $2 ] && [ ! $3 ]; then
            gcc $2 -o "$(basename $2 .c)"
        elif [ -f $3 ] && [ $3 ]; then
            dir=$3
            gcc $2 -o "$dir"
        elif [ -d $3 ] && [ $3 ]; then
            dir=$3
            gcc $2 -o "$dir$(basename $2 .c)"
        else
            echo "$2 is not an existing c file."
        fi
    elif [ $1 = "cs" ]; then
        if [ $2 ] && [ $2 = "-r" ]; then
            if [ $3 ]; then
                if [ -e $3 ] && [ $3 ]; then
                    mcs $3
                    mono ./"$(basename $3 .cs)".exe
                else
                    echo "$3 is not an existing file."
                fi
            else
                echo "Please select the file to compile and run."
            fi
        elif [ ! $2 ]; then
            echo "Please select the file to compile."
        elif [ -e $2 ]; then
            mcs $2
        else
            echo "$2 is not an existing file."
        fi
    else
        echo "$1 is not supported for compiling."
    fi
fi
