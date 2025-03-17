#!/bin/bash

# GitHub Release Download
# Author: @usrunsudo

function pause(){
    #read -p "$*"
    echo ""
    read -p "Press any key to continue ..."
    clear
}

function func_folder(){
    rm -r $HOME/Downloads/GitHub_Release_Download/
    mkdir $HOME/Downloads/GitHub_Release_Download
    cd $HOME/Downloads/GitHub_Release_Download/
}

function start(){
    var0=false
    func_folder
    menu0
}

function menu0(){
    while [ "$var0" != true ]
    do
        clear
        echo "---------- GitHub Release Download ----------"
        echo ""
        echo -n "Enter GitHub URL (User/Project): "
        read GITHUB_URL
        echo ""
        echo "Release for download:"
        echo "[1] Latest"
        echo "[2] By tag"
        echo "[0] exit"
        echo ""
        echo -n "Select menu item: "
        read MENU

        case $MENU in

            1)
            menu1
            ;;

            2)
            menu2
            ;;

            0)
            var0=true
            break
            ;;

            *)
            echo ""
            echo "unknown"
            echo ""
            pause
            ;;

        esac
    done
}

function menu1(){
    echo ""
    curl -s https://api.github.com/repos/$GITHUB_URL/releases/latest | jq -r ".assets[].browser_download_url" 2>&1 | tee ./!github_url.txt
    TAG_NAME=$(curl -s https://api.github.com/repos/$GITHUB_URL/releases/latest | jq -r ".tag_name") #2>&1 | tee -a ./!github_url.log
    func_download
}

function menu2(){
    echo ""
    echo -n "TAG_NAME = "
    read TAG_NAME
    curl -s https://api.github.com/repos/$GITHUB_URL/releases/tags/$TAG_NAME | jq -r ".assets[].browser_download_url" 2>&1 | tee ./!github_url.txt
    func_download
}

function func_download(){
    echo ""
    wget -O source-code_$TAG_NAME.zip https://github.com/$GITHUB_URL/archive/refs/tags/$TAG_NAME.zip 2>&1 | tee -a ./!github_url.log
    wget -O source-code_$TAG_NAME.tar.gz https://github.com/$GITHUB_URL/archive/refs/tags/$TAG_NAME.tar.gz 2>&1 | tee -a ./!github_url.log
    echo ""
    wget -i ./!github_url.txt 2>&1 | tee -a ./!github_url.log

    echo ""
    echo "------------------- DONE --------------------"

    var0=true
}

start
pause
exit 0
