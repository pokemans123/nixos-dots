#!/usr/bin/env bash

EMACS_ID=$(
    mmsg clients |
    awk '/Emacs/ {print $1; exit}'
)
emacsclient -e '(progn
                  (make-frame-visible (selected-frame))
                  (raise-frame)
                  (select-frame-set-input-focus (selected-frame))
                  (org-roam-capture))'
