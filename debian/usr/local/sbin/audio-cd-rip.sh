#!/bin/bash

LOGFILE=/var/log/ripper/cd.log;
echo -e "\nAudio CD RIP CALLED: $(date)" >> $LOGFILE;
abcde -Nx 2>&1 >> $LOGFILE;
if [ -d "[HOME]/Music/Unknown_Artist/Unknown_Album" ]; then
  UA_COUNT=`find [HOME]/Music/Unknown_Artist/* -maxdepth 1 -type d | wc -l`;
  mv [HOME]/Music/Unknown_Artist/Unknown_Album [HOME]/Music/Unknown_Artist/Album_${UA_COUNT};
  echo -e "\nSaved as: Album_${UA_COUNT}" >> $LOGFILE;
fi
exit 0;
