#! /bin/bash

ROOT=$(pwd)

  echo 'Enter your file name alias without any space in between example: woostore_pro_alias, woostoreproalias'
  read -r fileAlias
  echo "Enter a password for your file"
  read -r password
  
  cd tools || exit
  cd configs || exit
  FileName="keystore-config.conf"
  echo "Creating $FileName..."
  echo "# Information for your RELEASE KEYSTORE which will be used to sign the android application" > $FileName;
  cat >> keystore-config.conf <<EOL 
FILE_ALIAS=$fileAlias
PASSWORD=$password
EOL

cd "$ROOT" || exit