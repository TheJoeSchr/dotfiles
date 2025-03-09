#!/bin/env bash
while sudo inotifywait -r -e close_write -e delete /etc; do

  (
    /usr/bin/echo -en "$(date '+%Y%m%d%H%M%S')\t"
    sudo du -sm | cut -f1
  ) >>~/du.log
done
