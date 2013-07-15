#!/bin/bash

# Check if a directory exists.
# Taken from http://www.cyberciti.biz/tips/find-out-if-directory-exists.html.

DIR="$1"

if [ $# -ne 1 ]
then
  echo "Usage: $0 {dir-name}"
  exit 1
fi

if [ -d "$DIR" ]
then
  echo "Directory $1 exists."
else
  echo "Directory $1 does not exist."
fi
