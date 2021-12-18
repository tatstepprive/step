#!/bin/bash

MY_FILE=$MY_FILE
MY_ZiP_FILE=$MY_ZIP_FILE
MY_PASS=$MY_PASS

while true ; do
  case "$1" in
    --file) shift; MY_FILE=$1; shift;;
    -f) shift; MY_FILE=$1; shift;;
    --zfile) shift; MY_ZIP_FILE=$1; shift;;
    -zf) shift; MY_ZIP_FILE=$1; shift;;
    --pass) shift; MY_PASS=$1; shift;;
    -p) shift; MY_PASS=$1; shift;;
    *) break;;
  esac
done

if [ "$MY_FILE" = "" ]; then
  echo "ERROR: missing parameter, usage: zip_encrypt --file file"
  exit 1
fi
if [ "$MY_ZIP_FILE" = "" ]; then
  echo "ERROR: missing parameter, usage: zip_encrypt --zfile zipfile"
  exit 1
fi
if [ "$MY_PASS" = "" ]; then
  echo "ERROR: missing parameter, usage: zip_encrypt --pass pass"
  exit 1
fi

echo "file=$MY_FILE en zfile=$MY_ZIP_FILE pass=$MY_PASS"

#tar and remove files
tar czf ${MY_ZIP_FILE}.tar.gz ${MY_FILE} && rm ${MY_FILE}
#untar
##tar xzf ${MY_ZIP_FILE}.tar.gz
#encrypt
echo "${MY_PASS}" | gpg --batch --no-tty --yes --passphrase-fd 0 --force-mdc --symmetric ${MY_ZIP_FILE}.tar.gz && mv ${MY_ZIP_FILE}.tar.gz.gpg ${MY_ZIP_FILE}.tar.gz

echo "done"
