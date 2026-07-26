#!/usr/bin/env sh

pkill emacs &
emacs --daemon &
noctalia &
emacsclient -c -a 'vim' & disown
