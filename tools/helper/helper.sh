#!/bin/bash

ROOT=$(pwd)

delete_upload_keystore() {
  cd tools || exit
  cd certs || exit
  File=upload_key.keystore
  rm "$File"
  cd "$ROOT" || exit
}

delete_debug_keystore() {
  cd tools || exit
  cd certs || exit
  File=debug.keystore
  rm "$File"
  cd "$ROOT" || exit
}

delete_upload_key_if_exists() {
  File="$ROOT/tools/certs/upload_key.keystore"

  if [[ -f $File ]]; then
    echo "A file already exists"

    echo "Do you want to delete the already existing file to create a new one ? You will not be able to undo this action (y|n)"
    read answer
    if [[ $answer == "y" || $answer == "yes" ]]; then
      delete_upload_keystore "$File"
      echo "Deleted!"
    else
      exit 0;
    fi
  fi
}

delete_debug_key_if_exists() {
  File="$ROOT/tools/certs/debug.keystore"

  if [[ -f $File ]]; then
    delete_debug_keystore
  fi
}
