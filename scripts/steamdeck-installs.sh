#! /usr/bin/env bash

appsfile="./steamdeck-installs.csv"
# read from csv all tools tagged with "B" for buildtools
# . is *
for app in $(grep ".," $appsfile | cut -d, -f2 ) ; 
do 
  echo "INSTALLING: $app"; 
  pikaur -S --needed --noconfirm $app #>/dev/null 2>&1;
done
