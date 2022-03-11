#!/bin/bash

echo -e "\n"
echo "----------------Setup ENV----------------"
# Delete Previous Images
rm -f AP_CUSTOM.tar.md5
rm -rf temp-folder
curentDir=$(pwd)
echo "Current dir: $curentDir"


echo -e "\n\n"
echo "-------------Build TAR Files-------------"
mkdir temp-folder
for file in *.lz4; do
  echo "Current file: $file"
  tar --create \
      --file "$curentDir/temp-folder/$file.tar" \
      --format=gnu \
      --blocking-factor=20 \
      --quoting-style=escape \
      --owner=0 \
      --group=0 \
      --mode=644 \
      --verbose \
      --totals \
      $curentDir/$file
done


echo -e "\n\n"
echo "--Build AP_CUSTOM.tar--"
cd temp-folder
ls *.lz4.tar > temp-file.txt
tar --create \
    --file "AP_CUSTOM.tar" \
    --files-from "temp-file.txt" \
    --format=gnu \
    --blocking-factor=20 \
    --quoting-style=escape \
    --owner=0 \
    --group=0 \
    --mode=644 \
    --verbose \
    --totals
rm temp-file.txt
cd $curentDir


echo -e "\n\n"
echo "-------Create the MD5 Final File---------"
cd temp-folder
md5sum --text AP_CUSTOM.tar >> AP_CUSTOM.tar
cd $curentDir
mv temp-folder/AP_CUSTOM.tar AP_CUSTOM.tar.md5


echo -e "\n\n"
echo "-------------Cleaning Files--------------"
rm -rf temp-folder
