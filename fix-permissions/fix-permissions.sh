#!/usr/bin/env bash

# Set to variables the default permissions
umaskContent=$(umask)

for ((i=0;i<=2;i++)); do
  filePermissions[$i]=$((6-"${umaskContent:i+1:1}"))
  directoryPermissions[$i]=$((7-"${umaskContent:i+1:1}"))
done

filePermissionsString="${filePermissions[0]}${filePermissions[1]}${filePermissions[2]}"
directoryPermissionsString="${directoryPermissions[0]}${directoryPermissions[1]}${directoryPermissions[2]}"

# Change the owner to all the stuff inside the folder
sudo chown -R $(whoami):$(whoami) $1

# Fix the files permissions
sudo find $1 -type f -exec chmod "$filePermissionsString" {} \;

# Fix the directories permissions
sudo find $1 -type d -exec chmod "$directoryPermissionsString" {} \;
