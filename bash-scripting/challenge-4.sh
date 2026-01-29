#!/bin/bash
read -p "Enter source directory:" old_directory
mkdir -p backup_"$old_directory"
echo "Backup directory created: backup_"$old_directory"_$(date "+%Y-%m-%d")_$(date "+%H-%M") Copying .txt files..."
cp "$old_directory"/*.txt "backup_$old_directory"
echo "Backup complete! Files backed up:$(ls -1 "$old_directory"/*.txt 2> /dev/null | wc -l) "
