#!/bin/bash

print_args() {
    local filename=$1
    if [ -f "$filename" ]
    then 
        wc -l < $filename
    else
        echo "No file provided"
    fi
}

print_args "Level-1-Basics.sh"