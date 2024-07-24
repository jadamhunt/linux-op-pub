#!/bin/bash
### Create a Y/N prompt that only requires a single character; no enter key ###
read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
fi
