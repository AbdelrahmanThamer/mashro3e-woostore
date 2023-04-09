#!/bin/bash
ROOT=$(pwd)

source "$ROOT/tools/helper/helper.sh"
delete_debug_key_if_exists

keytool -genkey -v -keystore "$ROOT/tools/certs/debug.keystore" -storepass android -alias androiddebugkey -keypass android -keysize 2048 -validity 10000 -dname "CN=Android Debug,O=Android,C=US"