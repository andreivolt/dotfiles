#!/usr/bin/env bash

if [ -z "$1" ]; then
  file_param="@-"
else
  file_param=@"$1"
fi

curl -s -F "file=$file_param" https://file.io | jq -r '.link'