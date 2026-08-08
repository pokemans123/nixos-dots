#!/usr/bin/env bash

# emacsclient -e '(progn
#                   (make-frame-visible (selected-frame))
#                   (raise-frame)
#                   (select-frame-set-input-focus (selected-frame))
#                   (org-capture))'
#
emacsclient -e '(my/org-capture-frame)'
