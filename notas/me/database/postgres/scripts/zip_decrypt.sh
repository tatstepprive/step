#!/bin/bash

MY_ZiP_FILE=$MY_ZIP_FILE
MY_PASS=$MY_PASS

while true ; do
  case "$1" in
    --zfile) shift; MY_ZIP_FILE=$1; shift;;
    -zf) shift; MY_ZIP_FILE=$1; shift;;
    --pass) shift; MY_PASS=$1; shift;;
    -p) shift; MY_PASS=$1; shift;;
    *) break;;
  esac
done

if [ "$MY_ZIP_FILE" = "" ]; then
  echo "ERROR: missing parameter, usage: zip_encrypt --zfile zipfile"
  exit 1
fi
if [ "$MY_PASS" = "" ]; then
  echo "ERROR: missing parameter, usage: zip_encrypt --pass pass"
  exit 1
fi

echo "DEBUG: zfile=$MY_ZIP_FILE pass=$MY_PASS"

mv ${MY_ZIP_FILE}.tar.gz ${MY_ZIP_FILE}.tar.gz.gpg

#dencrypt
echo "${MY_PASS}" | gpg --batch --no-tty --yes --quiet --force-mdc --no-mdc-warning --ignore-mdc-error --passphrase-fd 0 --multifile --decrypt ${MY_ZIP_FILE}.tar.gz.gpg
#untar
tar xzf ${MY_ZIP_FILE}.tar.gz

echo "done"
