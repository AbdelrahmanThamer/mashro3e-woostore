#!/bin/bash
ROOT=$(pwd)

# Delete existing upload_key.keystore file
source "$ROOT/tools/helper/helper.sh"
delete_upload_key_if_exists

# Create upload_key.keystore file
source "$ROOT/tools/configs/keystore-config.conf"
keytool -genkey -v -keystore "$ROOT/tools/certs/upload_key.keystore" -keyalg RSA -storetype PKCS12 -keysize 2048 -validity 10000 -alias "$FILE_ALIAS" -storepass "$PASSWORD"

# Create key.properties file
cat > "$ROOT/tools/certs/key.properties" <<EOL
storePassword=$PASSWORD
keyPassword=$PASSWORD
keyAlias=$FILE_ALIAS
storeFile=../upload_key.keystore
EOL

# Move the upload_key.keystore and key.properties to android directory
cp -f "$ROOT/tools/certs/key.properties" "$ROOT/android"
cp -f "$ROOT/tools/certs/upload_key.keystore" "$ROOT/android"