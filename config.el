;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Hanif Carroll"
      user-mail-address "HanifCarroll@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 24))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Start emacs maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Visual line mode
(global-visual-line-mode 0)

;; Org Mode
(after! org
  (setq org-agenda-files '("~/org/inbox.org"
                          "~/org/gtd.org"
                          "~/org/tickler.org"))
  (setq org-capture-templates `(("t" "Todo [inbox]" entry
                                (file+headline "~/org/inbox.org" "Tasks")
                                "* TODO %? \n :PROPERTIES:\n :CREATED_AT: %U\n :END:")
                                ("n" "Note [inbox]" entry
                                (file+headline "~/org/inbox.org" "Notes")
                                "* %i%? \n %U")
                                ("T" "Tickler" entry
                                (file+headline "~/org/tickler.org" "Tickler")
                                "* %i%? \n %U")
                                ("j" "Journal" entry
                                 (file+headline ,(format-time-string "~/org/journal/%Y/%Y-%m-%d.org")
                                       ,(format-time-string "%A, %m/%d/%Y"))
                                ,(format-time-string "* %I:%M %p \n %?"))))
  (setq org-todo-keywords '((sequence "TODO(t)" "START(s)" "WAITING(w)" "|" "DONE(d)")))
  (setq org-todo-keyword-faces
    '(("START" . "#FFB269")
      ("WAITING" . "#FFDA69")))
  (setq org-directory "~/org/")
  (setq org-archive-location "%s_archive::datetree/* Archived Tasks"))

(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/DONE" 'file))

;; Orb Mobile
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/mobile.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
;; org-mobile-push hotkeys.
(global-set-key (kbd "C-c y") 'org-mobile-push)

;; Add timestamp when completing todo.
(setq org-log-done 'time)


;; Intialize Company Mode
(add-hook 'after-init-hook 'global-company-mode)

(setq company-idle-delay 1)
(setq company-minimum-prefix-length 2)

;; Map C-c C-o to start python interpreter
(map!
 (:after python
  (:map python-mode-map
    "C-c C-o" #'run-python)))


;; Grep files in directory and show results in dired.
(global-set-key (kbd "C-x C-g") 'helm-do-ag)
;; Search for files by name in a given directory.
(global-set-key (kbd "C-c C-g") 'helm-for-files)

;; Press enter in evil-normal-mode to insert a newline.
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "RET") nil))
