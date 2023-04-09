#!/bin/bash

ROOT=$(pwd)

echo $'\n'$'\n'"========= Debug Key Hash ========="$'\n'$'\n'
echo "When prompted for a password enter: android"
source "$ROOT/tools/configs/debug-config.conf"
keytool -exportcert -alias androiddebugkey -keystore "$DEBUG_KEYSTORE_PATH" | openssl sha1 -binary | openssl base64

source "$ROOT/tools/configs/keystore-config.conf"
echo $'\n'$'\n'"========= Release Key Hash ========="$'\n'$'\n'
echo "When prompted for a password enter the password you set in keystore-config.conf file"
keytool -exportcert -alias "$FILE_ALIAS" -keystore "$ROOT/tools/certs/upload_key.keystore" | openssl sha1 -binary | openssl base64
