#!/bin/bash
ROOT=$(pwd)
source "$ROOT/tools/configs/keystore-config.conf"
keytool -list -v -alias "$FILE_ALIAS" -keystore "$ROOT/tools/certs/upload_key.keystore"