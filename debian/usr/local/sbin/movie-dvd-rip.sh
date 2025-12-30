#!/bin/bash

LOGFILE=/var/log/rip.log
echo -e "\nMovie DVD RIP CALLED: $(date)" >> $LOGFILE;
TITLE=$(blkid -o value -s LABEL /dev/sr1);
echo -e "DVD Title: $TITLE" >> $LOGFILE;
HandBrakeCLI --input "/dev/sr1" --title "${TITLE}" --main-feature --output "[HOME]/Movies/${TITLE}.mp4";
rc=$?
if [[ $rc != 0 ]] ; then
  echo "FAILED!" >> $LOGFILE;
  eject /dev/sr1;
  exit $rc;
fi
sudo chmod +x "[HOME]/Movies/${TITLE}.mp4";
sudo chown [USER]:[USER] "[HOME]/Movies/${TITLE}.mp4";
echo "done!" >> $LOGFILE;
eject /dev/sr1;
exit 0;
