#!/bin/bash

LOGFILE=/var/log/ripper/dvd.log;
if [[ "${1}" == "--set-for-manual"  ]]; then
  sudo touch /usr/local/sbin/movie-dvd-rip-manual.flag; 
  echo "Set for manual mode... Please reinsert DVD";
  echo "and run 'movie-dvd-rip.sh --manual' to select title manually.";
  eject /dev/sr1;
  exit 0;
fi
if [[ "${1}" == "--manual" ]]; then
  sudo rm -f /usr/local/sbin/movie-dvd-rip-manual.flag;
  echo "Welcome to Manual Mode: $(date).";
  DVD_TITLE=$(blkid -o value -s LABEL /dev/sr1);
  echo "DVD Title detected as: ${DVD_TITLE}";
  read -p "Is this the correct DVD title? (Y/n): " TITLE_CONFIRM;
  if [[ "${TITLE_CONFIRM}" == "n" || "${TITLE_CONFIRM}" == "N" ]]; then
    read -p "Please enter the correct DVD title: " DVD_TITLE;
  fi
  sudo lsdvd /dev/sr1;
  read -p "Please enter the most likely 'title' for the main feature from those listed above: " SELECTED_TITLE;
  HandBrakeCLI --input "/dev/sr1" --title "${SELECTED_TITLE}" --output "/home/mrenyard/Movies/${DVD_TITLE}.mp4";
else
  if [[ -f /usr/local/sbin/movie-dvd-rip-manual.flag ]]; then
    echo -e "\nManual mode active..." >> $LOGFILE;
    exit 0;
  fi
  echo -e "\nMovie DVD RIP CALLED: $(date)" >> $LOGFILE;
  DVD_TITLE=$(blkid -o value -s LABEL /dev/sr1);
  echo -e "DVD Title: $DVD_TITLE" >> $LOGFILE;
  HandBrakeCLI --input "/dev/sr1" --title "${DVD_TITLE}" --main-feature --output "[HOME]/Movies/${DVD_TITLE}.mp4";
  rc=$?
  if [[ $rc != 0 ]] ; then
    echo "FAILED!" >> $LOGFILE;
    echo "Retry again with Manual Mode if the problem persists." >> $LOGFILE;
    echo "Run 'movie-dvd-rip.sh --set-for-manual', then reinsert DVD" >> $LOGFILE;
    echo "and then run 'movie-dvd-rip.sh --manual' to select title manually." >> $LOGFILE;
    eject /dev/sr1;
    exit $rc;
  fi
  echo "done!" >> $LOGFILE;
  sudo chown [USER]:[USER] "[HOME]/Movies/${DVD_TITLE}.mp4";
fi
eject /dev/sr1;
exit 0;
