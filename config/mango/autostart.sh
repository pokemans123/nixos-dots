#!/usr/bin/env sh

noctalia &

until emacsclient -e t >/dev/null 2&>1; do
    sleep 0.2
done
emacsclient -c -a 'vim' & disown
