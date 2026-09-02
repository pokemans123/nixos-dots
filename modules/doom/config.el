;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font-regular-normal-normal" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font-regular-normal-normal" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 18))
(load-theme 'noctalia t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq emacs-everywhere--copy-command "/run/current-system/sw/bin/sh")
(setq emacs-everywhere-clipboard-sleep-delay 0.5)

(after! org
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages
           '((python . t)
             (shell . t))))
  (after! org
    (setq org-agenda-files "~/org")
    (setq org-log-done 'time)
    (setq org-refile-targets
          '((org-agenda-files :maxlevel . 4))))

  (setq org-babel-default-header-args:python
        '((:session . "py")
          (:results . "output replace")
          (:exports . "both")))

  (setq org-confirm-babel-evaluate nil
        org-image-actual-width '(900))

  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/notes"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
(map! :leader
      "RET" #'(lambda ()
                (interactive)
                (find-file "~/org/bookmarks.org")))


(map! :leader
      :desc "Configure system"
      "f n"
      (cmd!
       (dired "~/nixos-dots")
       ))

(map! :leader
      :desc "Open Neotree"
      "e"
      #'neotree)
(map! :leader
      :desc "Define a word"
      "d w"
      #'dictionary-search)
(map! :leader
      :desc "Open LSP buffer"
      "k k"
      #'eldoc-doc-buffer)

(map! :leader
      :desc "Grep for strings"
      "f g"
      #'find-grep-dired)

(after! pdf-tools (add-hook 'pdf-view-mode-hook #'pdf-view-restore-mode))

(after! org
  (add-to-list 'org-src-lang-modes '("nix" . nix))
  (setq org-default-notes-file (concat org-directory "/captures.org"))

  ;; Capture templates
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "~/org/agenda.org" "Todo")
           "* TODO %^{Task}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")

          ("e" "Event" entry
           (file+headline "~/org/agenda.org" "Events")
           "* TODO %^{Event} :event:
SCHEDULED: %^T
:PROPERTIES:
:CREATED: %U
:CAPTURED: %a
:CONTACT:
:END:
%?")
          ("p" "Project" entry
           (file+headline "~/org/longterm.org" "Projects")
           "* PROJ %^{Project name}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n** TODO %?")

          ("i" "Idea" entry
           (file+headline "~/org/captures.org" "Ideas")
           "** IDEA %^{Idea}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")

          ("b" "Bookmark" entry
           (file+headline "~/org/bookmarks.org" "Bookmarks")
           "** [[%^{URL}][%^{Title}]] %^g
:PROPERTIES:
:CREATED: %U
:END:
"
           :empty-lines 0)

          ("n" "Note" entry
           (file+headline "~/org/captures.org" "Notes")
           "* [%<%Y-%m-%d %a>] %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?"
           :prepend t)))

  (defun org-capture-bookmark-tags ()
    "Get tags from existing bookmarks and prompt for tags with completion."
    (save-window-excursion
      (let ((tags-list '()))
        ;; Collect existing tags
        (with-current-buffer (find-file-noselect "~/org/bookmarks.org")
          (save-excursion
            (goto-char (point-min))
            (while (re-search-forward "^:TAGS:\\s-*\\(.+\\)$" nil t)
              (let ((tag-string (match-string 1)))
                (dolist (tag (split-string tag-string "[,;]" t "[[:space:]]"))
                  (push (string-trim tag) tags-list))))))
        ;; Remove duplicates and sort
        (setq tags-list (sort (delete-dups tags-list) 'string<))
        ;; Prompt user with completion
        (let ((selected-tags (completing-read-multiple "Tags (comma-separated): " tags-list)))
          ;; Return as a comma-separated string
          (mapconcat 'identity selected-tags ", ")))))

  ;; Helper function to select and link a contact (still used by the Event template)
  (defun org-capture-ref-link (file)
    "Create a link to a contact in contacts.org"
    (let* ((headlines (org-map-entries
                       (lambda ()
                         (cons (org-get-heading t t t t)
                               (org-id-get-create)))
                       t
                       (list file)))
           (contact (completing-read "Contact: "
                                     (mapcar #'car headlines)))
           (id (cdr (assoc contact headlines))))
      (format "[[id:%s][%s]]" id contact)))
  (setq org-agenda-files
        '("~/org")))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-plain-latex"
                 "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Set archive location to done.org under current date
;; (defun my/archive-done-task ()
;;   "Archive current task to done.org under today's date"
;;   (interactive)
;;   (let* ((date-header (format-time-string "%Y-%m-%d %A"))
;;          (archive-file (expand-file-name "~/org/done.org"))
;;          (location (format "%s::* %s" archive-file date-header)))
;;     ;; Only archive if not a habit
;;     (unless (org-is-habit-p)
;;       ;; Add COMPLETED property if it doesn't exist
;;       (org-set-property "COMPLETED" (format-time-string "[%Y-%m-%d %a %H:%M]"))
;;       ;; Set archive location and archive
;;       (setq org-archive-location location)
;;       (org-archive-subtree))))

;; Automatically archive when marked DONE, except for habits
;; (add-hook 'org-after-todo-state-change-hook
;;           (lambda ()
;;             (when (and (string= org-state "DONE")
;;                        (not (org-is-habit-p)))
;;               (my/archive-done-task))))

;; NOTE: commented out along with my/archive-done-task above, since that
;; function is disabled. Leaving this active would error on keypress.
;; (define-key org-mode-map (kbd "C-c C-x C-a") 'my/archive-done-task)

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))

(after! mu4e
  (setq mu4e-maildir "~/Mail"
        mu4e-get-mail-command "mbsync -a"
        mu4e-update-interval 300
        mu4e-compose-signature nil))

(use-package colorful-mode
  ;; :diminish
  ;; :ensure t ; Optional
  :custom
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))

(defun my/org-capture-frame ()
  (interactive)
  (let ((frame
         (make-frame
          '((name . "org-capture")
            (org-capture-frame . t)
            (minibuffer . t)
            (width . 80)
            (height . 20)
            (undecorated . t)))))
    (select-frame-set-input-focus frame)
    (org-capture)))

(defun my/org-capture-delete-frame ()
  (when (frame-parameter nil 'org-capture-frame)
    (delete-frame)))

(add-hook 'org-capture-after-finalize-hook #'my/org-capture-delete-frame)

(use-package! direnv
  :config
  (direnv-mode))

(after! projectile
  (setq projectile-project-search-path '("~/Projects")))

(defun my/make-file-executable ()
  (interactive)
  (set-file-modes buffer-file-name
                  (logior (file-modes buffer-file-name) #o111))
  (message "Made %s executable" buffer-file-name))

(map! :leader
      :desc "Make file executable"
      "m x" #'my/make-file-executable)
