#!/bin/bash

echo "Downloading fonts from font list"

while read fonts; do
	cat fonts |rev|  cut -d"/" -f1 |rev
	wget $fonts 
done < ./fonts




