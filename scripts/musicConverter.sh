#!/bin/bash

# This shell script will convert a YT vid rip to MP3
# must know path and filename to source mp4 
# output file is the name WITHOUT the extension
##
# Prereqs:
#	ffmpeg
#	libmp3lame

echo "======================="
echo "Mp3 Conversion Tool v.1"
echo "======================="

echo "Enter the file name to convert:"
read InputFileName

if test -f InputFileName; then
	echo "found file $InputFileName"
fi

echo "Enter the output filename: [FILENAME].mp3"
echo "**No Extension is required**"
read outputFileName

sleep .5
echo "Preparing to convert video $InputFileName to $outputFileName .mp3..."

ffmpeg -i $InputFileName -acodec libmp3lame -metadata TITLE="$outputFileName" $outputFileName.mp3


#411  ffmpeg -i Cyberpunk\ 2077\ Lo-Fi\ Beats\ Playlist\ -\ Night\ City\ Chillhop\ Radio.mp4 -acodec libmp3lame -metadata TITLE="Nightcity Chillhop" Nightcity-Chillhop.mp3
