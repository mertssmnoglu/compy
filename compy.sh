#!/bin/bash

checkIfInstalled(){
    if [ "$(which $compilerBin)" != "" ]
    then
        echo "Compiling..."
    else
        echo "You do not have $compilerBin on your machine"
        exit 1
    fi
}
selectCompiler(){
    if [ -e $file ];then
        if [ ${file: -2} == ".c" ]; then
            compilerLang="c"
            compilerBin="gcc"
            compilerPackage="build-essential"
        elif [ ${file: -3} == ".cs" ];then
            compilerLang="cs"
            compilerBin="mono"
            compilerPackage="mono-complete"
        else
            echo "$file is not supported for compiling"
            exit 1
        fi
    else
        echo "$file is not an existing file"
        exit 1
    fi
}
compile(){
    if [ $compilerLang == "cs" ];then
        mcs $file
    elif [ $compilerLang == "c" ];then
        gcc $file -o $(basename $file .c)
    fi
}

if [ ! $1 ]; then
    echo "No arguments provided!"
    exit 1
else
    file=$1
fi

function main() {
    selectCompiler
    checkIfInstalled
    compile
}
main