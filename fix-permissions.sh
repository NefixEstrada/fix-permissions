#!/usr/bin/env bash

# Set to variables the default permissions
umaskContent=$(umask)
filePermissions[0]=$((6-"${umaskContent:1:1}"))
filePermissions[1]=$((6-"${umaskContent:2:1}"))
filePermissions[2]=$((6-"${umaskContent:3:1}"))
filePermissionsString="${filePermissions[0]}${filePermissions[1]}${filePermissions[2]}"
directoryPermissions[0]=$((7-"${umaskContent:1:1}"))
directoryPermissions[1]=$((7-"${umaskContent:2:1}"))
directoryPermissions[2]=$((7-"${umaskContent:3:1}"))
directoryPermissionsString="${directoryPermissions[0]}${directoryPermissions[1]}${directoryPermissions[2]}"

# Change the owner to all the stuff inside the folder
sudo chown -R $(whoami):$(whoami) $1

# Fix the files permissions
sudo find $1 -type f -exec chmod "$filePermissionsString" {} \;

# Fix the directories permissions
sudo find $1 -type d -exec chmod "$directoryPermissionsString" {} \;
