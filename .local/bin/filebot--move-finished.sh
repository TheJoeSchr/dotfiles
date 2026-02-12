#! /usr/bin/bash

rm /mnt/diskpool/NoMirror/Media/amc.txt

filebot -rename -script fn:amc --log-file /mnt/diskpool/NoMirror/Media/amc.log --output "/mnt/diskpool/NoMirror/Media" --action move -non-strict "/mnt/diskpool/NoMirror/Downloads/Finished" --conflict auto --def excludeList=amc.txt movieFormat="{emby}" seriesFormat="{emby}" subtitles=en music=n --def emby=127.0.0.1:12e1a74d754c456794f3a148b643c2d3 deleteAfterExtract=n clean=y unsorted=y minFileSize=10

# 1eb949eb75be5c2e64884ab6eb2f1fc8c11c63ed
# --def movieFormat="M:/{plex}" seriesFormat="S:/{plex}" animeFormat="T:/{plex}" musicFormat="D:/{plex}"
# --filter "age < 5 || 5 <= model.age.min()" --def "ut_label=TV"
