#!/bin/bash
ROOT=$(pwd)
echo "The password for debug keystore is: android"
source "$ROOT/tools/configs/debug-config.conf"
keytool -list -v -alias androiddebugkey -keystore "$DEBUG_KEYSTORE_PATH"