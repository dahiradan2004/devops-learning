#!/bin/bash
mkdir -p Arena_Boss
cd Arena_Boss || exit 1


touch file1.txt file2.txt file3.txt file4.txt file5.txt

min=10
max=20

for file in file*.txt
do
    linesAmount=$((min + RANDOM % (max - min + 1)))
    i=0

    while [ "$i" -lt "$linesAmount" ]
    do
        echo "This is a line of text" >> "$file"
        i=$((i + 1))
    done
done

echo "Files sorted by size:"
du -h file*.txt | sort -h

mkdir -p Victory_Archive

for file in file*.txt
do
    if grep -q "Victory" "$file"; then
        mv "$file" Victory_Archive/
    fi
done

