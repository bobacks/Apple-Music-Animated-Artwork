[TOC]

This script downloads the new style of videos Apple Music is using for album covers. All you need to do is supply the album URL, and it'll download the highest resolution available from .m3u8 format and use FFMPEG to convert it to MP4.

You'll need to install a few things for this to work. I wrote this shell script for macOS, but you can use it on other platforms.


#### Needed

- ffmpeg;
- curl;
- ggrep (GNU grep because the macOS version is not complete);

#### Optional
```html
brew install ffmpeg curl grep
```
#### Sidenote
For some reason, on my first try [brew](https://brew.sh "brew") didn't download the full ffmpeg, so I downloaded it directly. Download the ffmpeg binary(.exe for Windows) for your OS from [FFBinaries](https://ffbinaries.com/downloads "FFBinaries") and put that binary inside ```Apple-Music-Animated-Artwork```.



#### Usage: 
```html 
./apple_music_videoalbumcover.sh <Apple Music Album URL>
```


Enjoy
Disclaimer: I am no code genius. This is a quick hack.
