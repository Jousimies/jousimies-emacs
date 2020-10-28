;;; Code:
(require 'defun-org)
(require 'cl)
(require 'org-habit)
(require 'org-pomodoro)
(with-eval-after-load 'org
  (setq org-odt-preferred-output-format "docx") ;ODT转换格式默认为docx
  (setq org-startup-folded nil)                 ;默认展开内容
  (setq org-startup-indented t)                 ;默认缩进内容

  (defun org-export-docx ()
    (interactive)
    (let ((docx-file (concat (file-name-sans-extension (buffer-file-name)) ".docx"))
          (template-file (concat (file-name-as-directory lazycat-emacs-root-dir)
                                 (file-name-as-directory "template")
                                 "template.docx")))
      (shell-command (format "pandoc %s -o %s --reference-doc=%s"
                             (buffer-file-name)
                             docx-file
                             template-file
                             ))
      (message "Convert finish: %s" docx-file))))

(dolist (hook (list
               'org-mode-hook
               ))
  (add-hook hook '(lambda ()
                    (require 'valign)
                    (valign-mode)

                    (setq truncate-lines nil) ;默认换行

                    (lazy-load-set-keys
                     '(
                       ("M-h" . set-mark-command) ;选中激活
                       )
                     org-mode-map
                     )
                    )))
(setq org-agenda-inhibit-startup t) ;; ~50x speedup
  (setq org-agenda-span 'day)
  (setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
  (setq org-agenda-window-setup 'current-window)
  (add-hook 'org-agenda-mode-hook
 	    '(lambda () (org-defkey org-agenda-mode-map "w" (lambda () (interactive) (setq bh/hide-scheduled-and-waiting-next-tasks t) (bh/widen))))
 	    'append)

  (add-hook 'org-agenda-mode-hook
 	    '(lambda () (org-defkey org-agenda-mode-map "n" 'bh/narrow-to-subtree))
 	    'append)

  (add-hook 'org-agenda-mode-hook
 	    '(lambda () (org-defkey org-agenda-mode-map "u" 'bh/narrow-up-one-level))
 	    'append)

  (setq org-show-entry-below (quote ((default))))

  ;;Define org file
  (setq org-agenda-files (list "~/Nextcloud/Li.Schedule/GTD/Inbox.org"
			       "~/Nextcloud/Li.Schedule/GTD/Son_DuanShuYi.org"
			       "~/Nextcloud/Li.Schedule/GTD/Family.org"
			       "~/Nextcloud/Li.Schedule/GTD/Someday.org"
			       "~/Nextcloud/Li.Schedule/GTD/General.org"
			       "~/Nextcloud/Li.Schedule/GTD/Habit.org"
			       "~/Nextcloud/Li.Schedule/GTD/Work.org"
			       "~/Nextcloud/Li.Schedule/GTD/Reflection.org"
			       ))

  ;; org todo keywords
  (setq org-todo-keywords (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
				  (sequence "WAITING(w@/!)" "HOLD(h@/!)" "SOMEDAY(s)" "|" "CANCELLED(c@/!)"))))

  (setq org-todo-keyword-faces
	(quote (("TODO" :foreground "red" :weight bold)
		;;("DOING" :foreground "Black" :weight bold)
		("NEXT" :foreground "green" :weight bold)
		("DONE" :foreground "forest green" :weight bold)
		("WAITING" :foreground "orange" :weight bold)
		("HOLD" :foreground "magenta" :weight bold)
		("CANCELLED" :foreground "forest green" :weight bold))))

  (setq org-todo-state-tags-triggers
	(quote (("CANCELLED" ("CANCELLED" . t))
		("WAITING" ("WAITING" . t))
		("SOMEDAY" ("WAITING") ("SOMEDAY" . t))
		(done ("WAITING") ("SOMEDAY"))
		("TODO" ("WAITING") ("CANCELLED") ("SOMEDAY"))
		("NEXT" ("WAITING") ("CANCELLED") ("SOMEDAY"))
		("DONE" ("WAITING") ("CANCELLED") ("SOMEDAY")))))

  ;;org tags
  ;; Tags with fast selection keys
  (setq org-tag-alist (quote ((:startgroup)
			      ("@office" . ?o)
			      ("@home" . ?H)
			      ("@way" . ?W)
			      (:endgroup)
			      ("WAITING" . ?w)
			      ("HOLD" . ?h)
			      ("PERSONAL" . ?P)
			      ("WORK" . ?W)
			      ("NOTE" . ?n)
			      ("CANCELLED" . ?c))))
  ;; Allow setting single tags without the menu
  ;(setq org-fast-tag-selection-single-key (quote expert))
  ;; For tag searches ignore tasks with scheduled and deadline dates
  ;(setq org-agenda-tags-todo-honor-ignore-options t)
  ;(setq org-agenda-tags-column 50)



  ;;org-capture
  (setq org-capture-templates
  	'(("t" "Todo" entry (file "~/Nextcloud/Li.Schedule/GTD/Inbox.org")
  	   "* TODO [#B]  %?\n  %i\n %U"
  	   :empty-lines 1)
  	  ))

  (add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

    ;; Custom agenda command definitions
  (setq org-agenda-custom-commands
        (quote (
		("a" "Agenda"
		 ((agenda #1="" nil)
		  (tags "REFILE"
			((org-agenda-overriding-header "Tasks to Refile")
			 (org-tags-match-list-sublevels nil)))
		  (tags-todo "-CANCELLED/!"
			     ((org-agenda-overriding-header "Stuck Projects")
			      (org-agenda-skip-function 'bh/skip-non-stuck-projects)
			      (org-agenda-sorting-strategy
			       '(category-keep))))
		  (tags-todo "-SOMEDAY-CANCELLED/!"
			     ((org-agenda-overriding-header "Projects")
			      (org-agenda-skip-function 'bh/skip-non-projects)
			      (org-tags-match-list-sublevels 'indented)
			      (org-agenda-sorting-strategy
			       '(category-keep))))
		  (tags-todo "-CANCELLED/!NEXT"
			     ((org-agenda-overriding-header (concat "Project Next Tasks"
								    (if bh/hide-scheduled-and-waiting-next-tasks ""
								      " (including WAITING and SCHEDULED tasks)")))
			      (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
			      (org-tags-match-list-sublevels t)
			      (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-sorting-strategy
			       '(todo-state-down effort-up category-keep))))
		  (tags-todo "-REFILE-CANCELLED-WAITING-SOMEDAY/!"
			     ((org-agenda-overriding-header (concat "Project Subtasks"
								    (if bh/hide-scheduled-and-waiting-next-tasks ""
								      " (including WAITING and SCHEDULED tasks)")))
			      (org-agenda-skip-function 'bh/skip-non-project-tasks)
			      (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-sorting-strategy
			       '(category-keep))))
		  (tags-todo "-REFILE-CANCELLED-WAITING-SOMEDAY/!"
			     ((org-agenda-overriding-header (concat "Standalone Tasks"
								    (if bh/hide-scheduled-and-waiting-next-tasks ""
								      " (including WAITING and SCHEDULED tasks)")))
			      (org-agenda-skip-function 'bh/skip-project-tasks)
			      (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-sorting-strategy
			       '(category-keep))))
		  (tags-todo "-CANCELLED+WAITING|SOMEDAY/!"
			     ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
								    (if bh/hide-scheduled-and-waiting-next-tasks
									""
								      " (including WAITING and SCHEDULED tasks)")))
			      (org-agenda-skip-function 'bh/skip-non-tasks)
			      (org-tags-match-list-sublevels nil)
			      (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
			      (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
		  (tags "-REFILE/"
			((org-agenda-overriding-header "Tasks to Archive")
			 (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
			 (org-tags-match-list-sublevels nil))))
		 nil))))

 ;; Separate drawers for clocking and logs
  (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
  ;; Save clock data and state changes and notes in the LOGBOOK drawer
  (setq org-clock-into-drawer t)
  (setq org-log-into-drawer t)
  ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)




(provide 'init-org)
