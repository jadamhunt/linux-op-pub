#!/bin/bash
# set -euo pipefail
#https://gist.github.com/djravine/7a66478c37974940e8c39764d59d35fa

function read_yn {
  MESSAGE=$1
  TIMEOUTREPLY=$2
  READTIMEOUT=$3
  NORMALREPLY="Y"
  if [ -z "${TIMEOUTREPLY}" ]; then
      TIMEOUTREPLY="Y"
  fi
  if [ -z "${READTIMEOUT}" ]; then
      READTIMEOUT=5
  fi
  TIMEOUTREPLY_UC=$( echo $TIMEOUTREPLY | awk '{print toupper($0)}' )
  TIMEOUTREPLY_LC=$( echo $TIMEOUTREPLY | awk '{print tolower($0)}' )
  if [ "${TIMEOUTREPLY_UC}" == "Y" ]; then
    NORMALREPLY="N"
  fi
  NORMALREPLY_UC=$( echo $NORMALREPLY | awk '{print toupper($0)}' )
  NORMALREPLY_LC=$( echo $NORMALREPLY | awk '{print tolower($0)}' )
  for (( i=$READTIMEOUT; i>=1; i--)); do
    printf "\r${MESSAGE} [${NORMALREPLY_UC}${NORMALREPLY_LC}/${TIMEOUTREPLY_UC}${TIMEOUTREPLY_LC}] ('${TIMEOUTREPLY_UC}' in ${i}s) "
    read -s -n 1 -t 1 WAITREADYN
    if [ $? -eq 0 ]; then
      if [[ "${WAITREADYN}" = "y" || "${WAITREADYN}" = "Y" || "${WAITREADYN}" = "n" || "${WAITREADYN}" = "N" ]]; then
        ./menu_system.sh
        break
      else
        sleep 1
      fi
    fi
  done
  printf "\r${MESSAGE} [${NORMALREPLY_UC}${NORMALREPLY_LC}/${TIMEOUTREPLY_UC}${TIMEOUTREPLY_LC}] ('${TIMEOUTREPLY_UC}' in 0s)      "
  yn=""
  if [ -z $WAITREADYN ]; then
    echo -e "\nNo input entered: Defaulting to '${TIMEOUTREPLY_UC}'"
    yn="${TIMEOUTREPLY_UC}"
  else
    echo -e "\n${WAITREADYN}"
    yn="${WAITREADYN}"
  fi
}

read_yn "TESTING" "y" 5

