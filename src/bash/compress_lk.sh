#!/usr/bin/env bash
set -e

function compress () {
  echo `echo $1 | awk -v FS="" 'BEGIN{ res="" } { ch=$1; c=0; i=0; do {i+=1; if (ch == $i) c+=1; else { res=res""c""ch; ch=$i; c=1 } } while (i <=NF) } END{ print res }'`
}

if [[ "$(compress 'AAABBAAC')" != "3A2B2A1C" ]]; then
  echo "Assertion has failed."
  exit 255
fi
