#!/bin/bash

# sshfs_mount.sh
# Author: @usrunsudo

# SSHFS - A network filesystem client to connect to SSH servers
# About: SSHFS allows you to mount a remote filesystem using SFTP. Most SSH servers support and enable this SFTP access by default, so SSHFS is very simple to use - there's nothing to do on the server-side.
# How to use: sshfs [user@]hostname:[directory] mountpoint
# Install sshfs: sudo apt install sshfs

USER="user" # user on remote PC with SSH Server
SERVER="server.domain" # IP address or PC name, example: server.domain
PORT="22" # Default for SSH

FOLDER_1_REMOTE="/srv/dev-disk-by-uuid-00000000-0000-0000-0000-000000000000/FOLDER_1_REMOTE"
FOLDER_1_LOCAL="/mnt/FOLDER_1_LOCAL/"

FOLDER_2_REMOTE="/srv/dev-disk-by-uuid-00000000-0000-0000-0000-000000000000/FOLDER_2_REMOTE"
FOLDER_2_LOCAL="/mnt/FOLDER_2_LOCAL/"

sshfs_mount(){
    if [ -d $5 ]
    then
        echo "Директория '$5' существует."
    else
        echo "Директория '$5' отсутствует и будет создана (требуются права sudo)."
        echo "sudo mkdir $5"
        sudo mkdir $5
        echo "sudo sudo chmod -R 777 $5"
        sudo sudo chmod -R 777 $5
    fi
    echo "sshfs -p $3 $1@$2:$4 $5"
    sshfs -p $3 $1@$2:$4 $5
    echo ""
}

start(){
    clear
    echo "sshfs_mount.sh"
    echo ""
}

start
sshfs_mount $USER $SERVER $PORT $FOLDER_1_REMOTE $FOLDER_1_LOCAL
sshfs_mount $USER $SERVER $PORT $FOLDER_2_REMOTE $FOLDER_2_LOCAL
