#!/bin/bash

search_word=$1


find / -type f -name '*.log' | while read file
do 
if grep -q "$search_word" "$file"
then echo $file
fi
done 