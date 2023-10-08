#!/bin/bash

# You'll need to install a few things
# Use this if you've installed Brew on your macOS - "brew install ffmpeg curl grep"
# If you're using this on Windows or Linux, I'm sure you know what you're doing.
# Created on 6th of Oct 2023


# Check if the URL is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Apple Music Album URL>"
    exit 1
fi

# Fetch the content of the provided URL
content=$(curl -s "$1")

# Extract the title from the content
title=$(echo "$content" | ggrep -oP '<title>\K(.*?)(?=</title>)' | sed 's/[^a-zA-Z0-9]/_/g')

# Extract the .m3u8 URL from the content
m3u8_url=$(echo "$content" | awk -F'"' '/<amp-ambient-video.*?src=/ { for(i=1; i<=NF; i++) if ($i ~ /^https:\/\/.*\.m3u8$/) print $i }')

# Check if the URL was extracted successfully
if [ -z "$m3u8_url" ]; then
   echo "Failed to extract the .m3u8 URL."
  exit 1
fi

# Use ffmpeg to download and convert the content
./ffmpeg -i "$m3u8_url" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 "${title}.mp4"

echo "Download complete: ${title}.mp4"
