#!/bin/bash

read -p "Enter filename to check:" filename
echo $filename
if [ -f "$filename" ];then
    [ -r "$filename" ] && echo "Readable ✓" || echo "Readable ✗"
    [ -w "$filename" ] && echo "Writable ✓" || echo "Writable ✗"
    [ -x "$filename" ] && echo "Executable ✓" || echo "Executable ✗"
else
    echo "File '$filename' doesn't exist."
fi