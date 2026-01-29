#!/bin/bash
mkdir bash_demo
cd bash_demo || exit 1
touch demo.txt
echo "Directoy $(basename "$PWD") created. File demo.txt created."
echo "This file was created by a Bash script on $(date "+%Y-%m-%d")" >> demo.txt