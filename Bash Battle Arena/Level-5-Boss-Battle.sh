#!/bin/bash

mkdir "Battlefield"
cd Battlefield
touch "knight.txt"
touch "sorcerer.txt"
touch "rogue.txt"
cd ..

if [ -f "Battlefield/knight.txt" ]
then 
    mkdir Archive
    mv Battlefield/knight.txt Archive
    echo "Archive contents:" 
    ls Archive
    
fi
echo "Battlefield contents:" 
ls Battlefield
new line
new line
new line
new line
new line
new line
new line
new line
new line
new line
new line
new line
new line
new line
new line
new line
