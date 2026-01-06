# CD-ROM Auto RIPper.
## RIP Movie DVDs and Music CDs Automatically.
### Automatic detection of media type on CD-ROM insert; DVD (Movie) CD (Music) and makes copies for relevant Home folders (~/Music, ~/Movies) on Headless Debian based Linux machines.
Description: CD-ROM Auto RIPper.
  Auto RIP CD (\~/Music) and DVD (\~/Movies):
   - RIPs audio CD to Music folder
   - RIPs DVD movies to Movies folder
### Manual ripping for problematic DVDs
1) Preparing CD-ROM for manual use.
```console
movie-dvd-rip.sh --set-for-manual
```
2) Insert problematic DVD into CD-ROM drive.
3) Starting manual ripping process.
```console
movie-dvd-rip.sh --manual
```
4) Following instructions.

NOTE: When prompted by *"Please enter the most likely 'title' for the main feature from those listed above: "* you will want to locate the title with the most chapters as the most likely 'main feature'.
