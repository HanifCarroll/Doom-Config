;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; HERE ARE SOME additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; <K> - On highlighted function/macro to see documentation, including demos.
;; <gd> - To jump to definition.

;; Start emacs maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Hanif Carroll"
      user-mail-address "HanifCarroll@gmail.com")
(setq doom-font (font-spec :family "monospace" :size 24))
(setq doom-theme 'doom-palenight)
(setq display-line-numbers-type t)

;; Intialize Company Mode autocomplete.
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 1)
(setq company-minimum-prefix-length 2)

;; Org Mode config.
(load! "./org-config.el")

;; Map C-c C-o to start python interpreter
(map!
 (:after python
  (:map python-mode-map
    "C-c C-o" #'run-python)))

;; Tab for autocomplete
(define-key global-map "\t" 'company-complete-common)

;; Grep files in directory and show results in dired.
(global-set-key (kbd "C-x C-g") 'helm-do-ag)
;; Search for files by name in a given directory.
(global-set-key (kbd "C-c C-g") 'helm-for-files)

;; Press enter in evil-normal-mode to insert a newline.
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "RET") nil))

;; Open git diff in a popup window.
(map! :leader
      :desc "Show diff in popup." "g p" #'git-gutter:popup-hunk)

