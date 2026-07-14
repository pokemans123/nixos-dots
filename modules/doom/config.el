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

  (setq org-babel-default-header-args:python
        '((:session . "py")
          (:results . "output replace")
          (:exports . "both")))

  (setq org-confirm-babel-evaluate nil
        org-image-actual-width '(900))

  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images))

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
(defun my/vterm-here ()
  "Open vterm in current window."
  (interactive)
  (let ((default-directory (or (and buffer-file-name (file-name-directory buffer-file-name))
                               default-directory))
        (display-buffer-alist nil))  ; bypass all display rules
    (pop-to-buffer-same-window (vterm "*vterm*"))))
(map! :leader
      :desc "Open terminal"
      "t t" #'vterm
      )

(map! :leader
      :desc "Open terminal in other window"
      "t o" #'my/vterm-here
      )

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
(defun my/token ()
  "Open github token"
  (interactive)
  (find-file "~/Documents/token.txt"))

(after! pdf-tools (add-hook 'pdf-view-mode-hook #'pdf-view-restore-mode))

(after! org
  (add-to-list 'org-src-lang-modes '("nix" . nix)))

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
