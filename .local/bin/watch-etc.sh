#!/bin/env bash
# original inotifywait -qq -r -e
while sudo inotifywait -r -e close_write -e delete /etc; do

  (
    /usr/bin/echo -en "$(date '+%Y%m%d%H%M%S')\t"
    du -sm | cut -f1
  ) >>~/du.log
done
