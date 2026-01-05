#!/bin/bash

file_path=$1

for file in "$file_path"/*.txt
do 
    wc -c "$file"
done | sort -n 

    