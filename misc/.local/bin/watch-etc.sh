#!/bin/env bash
while sudo inotifywait -r -e close_write -e delete /etc; do

  (
    /usr/bin/echo -en "$(date '+%Y%m%d%H%M%S')\t"
    sudo df -h /etc
  ) >>~/du.log
done
