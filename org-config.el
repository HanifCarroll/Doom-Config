;;; ~/.doom.d/org-config.el -*- lexical-binding: t; -*-

;; Must be set before org loads!
(setq org-directory "~/org/")

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

  (setq org-archive-location "%s_archive::datetree/* "))

(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/DONE" 'file))

;; Orb Mobile

(setq org-mobile-inbox-for-pull "~/org/inbox.org")

;; Set to the name of the file where new notes will be stored
(setq org-mobile-capture-file "~/Dropbox/Apps/MobileOrg/inbox.org")

;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;; org-mobile-push hotkey.
(global-set-key (kbd "C-c y") 'org-mobile-push)

;; Daily work journal hotkey.
(defun my/daily-work-file ()
  "Open work related org file for the day."
  (find-file (format-time-string "~/org/cisco/daily-tasks/%F.org")))
(global-set-key (kbd "C-x w") (lambda () (interactive) (my/daily-work-file)))

;; Add timestamp when completing todo.
(setq org-log-done 'time)
