#!/bin/sh

# GitHub Release Download
# Author: @usrunsudo

echo "---------- GitHub Release Download ----------"
echo ""
echo -n "Enter GitHub URL (User/Project): "
read GITHUB_URL

rm -r $HOME/Downloads/GitHub_Release_Download/
mkdir $HOME/Downloads/GitHub_Release_Download
cd $HOME/Downloads/GitHub_Release_Download/

echo ""
curl -s https://api.github.com/repos/$GITHUB_URL/releases/latest | jq -r ".assets[].browser_download_url" 2>&1 | tee ./!github_url.txt

TAG_NAME=$(curl -s https://api.github.com/repos/$GITHUB_URL/releases/latest | jq -r ".tag_name")
#touch ./!github_url.txt
#echo "" >> ./!github_url.txt
#echo "https://github.com/$GITHUB_URL/archive/refs/tags/$TAG_NAME.zip" >> ./!github_url.txt
#echo "https://github.com/$GITHUB_URL/archive/refs/tags/$TAG_NAME.tar.gz" >> ./!github_url.txt
#echo "" >> ./!github_url.txt

# wget -i ./!github_url.txt > ./!github_url.log 2>&1
echo ""
wget -O source-code_$TAG_NAME.zip https://github.com/$GITHUB_URL/archive/refs/tags/$TAG_NAME.zip 2>&1 | tee -a ./!github_url.log
wget -O source-code_$TAG_NAME.tar.gz https://github.com/$GITHUB_URL/archive/refs/tags/$TAG_NAME.tar.gz 2>&1 | tee -a ./!github_url.log
echo ""
wget -i ./!github_url.txt 2>&1 | tee -a ./!github_url.log

echo ""
echo "------------------- DONE --------------------"
