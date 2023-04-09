#!/bin/bash

ROOT=$(pwd)
source "$ROOT/tools/configs/keystore-config.conf"
echo $'\n'$'\n'"========= Release Key Hash ========="$'\n'$'\n'
echo "When prompted for a password enter the password you set in keystore-config.conf file"
keytool -exportcert -alias "$FILE_ALIAS" -keystore "$ROOT/tools/certs/upload_key.keystore" | openssl sha1 -binary | openssl base64
