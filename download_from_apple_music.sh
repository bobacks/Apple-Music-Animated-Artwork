#!/bin/bash

# By Boback Shahsafdari
# v1.0 07th Oct 2023 - Birth
# v1.1 12th Oct 2023 - Better file names for generated title



# Check if the URL is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Apple Music Album URL>"
    exit 1
fi

# Fetch the content of the provided URL
content=$(curl -s "$1")

# Extract the title from the content
title=$(echo "$content" | grep -oP '<title>\K(.*?)(?=</title>)' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/[^a-zA-Z0-9]+/ /g' -e 's/ /_/g' -e 's/^[_?]*//' -e 's/_-_$//' -e 's/_-_Apple_Music$//' -e 's/_Playlist_/_/')


# Extract the .m3u8 URL from the content
m3u8_url=$(echo "$content" | awk -F'"' '/<amp-ambient-video.*?src=/ { for(i=1; i<=NF; i++) if ($i ~ /^https:\/\/.*\.m3u8$/) print $i }')

# Check if the URL was extracted successfully
if [ -z "$m3u8_url" ]; then
   echo "Failed to extract the .m3u8 URL."
  exit 1
fi

# Use ffmpeg to download and convert the content
ffmpeg -i "$m3u8_url" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 "${title}.mp4"

# OPTIONAL
# Use ffmpeg binary downloaded to the same folder to download and convert the content
# ./ffmpeg -i "$m3u8_url" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 "${title}.mp4"

echo "Download complete: ${title}.mp4"
