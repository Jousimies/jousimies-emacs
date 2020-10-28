(require 'evil)
(require 'hydra)
(require 'general)
(require 'yasnippet)
(require 'restart-emacs)
(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(setq-default
   evil-want-C-d-scroll t
   evil-want-C-u-scroll t )
;;开启evil模式
(evil-mode 1)
;;设置一些mode默认启用emacs模式
(dolist (p '(
	       (deft-mode . emacs)
	       (Custom . emacs)
	       (image-mode . emacs)
	       (message-mode . emacs)
	       (calendar-mode . emacs)
	       (special-mode . emacs)
	       (grep-mode . emacs)
	       (Info-mode . emacs)
	       (term-mode . emacs)
	       (log-edit-mode . emacs)
	       (help-mode . emacs)
	       (eshell-mode . emacs)
	       (shell-mode . emacs)
	       (fundamental-mode . emacs)
	       (profiler-report-mode . emacs)
	       (dired-mode . emacs)
	       (compilation-mode . emacs)
	       (speedbar-mode . emacs)
	       (ivy-occur-mode . emacs)
	       (ivy-occur-grep-mode . normal)
	       ))
(evil-set-initial-state (car p) (cdr p)))
;;光标颜色
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))


;;yasnippet 注销tab键粘贴
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)


;;buffer
(defhydra hydra-buffer (:color red :hint nil)
  "
^Buffer^                    ^Cancel^
-------------------------------------------
_b_ : Buffer              _q_ : Cancel
_d_ : DeleteBuffer
_e_ : EvalBuffer
_r_ : RevertBuffer
"
("c" save-buffers-kill-terminal :exit t)
("b" counsel-ibuffer :exit t)
("d" evil-delete-buffer :exit t)
("e" eval-buffer :exit t)
("r" revert-buffer :exit t)
("q" nil)
)


;;file 相关
(defhydra hydra-file (:color red :hint nil)
  "File"
("f" counsel-find-file "FindFile" :exit t)
("r" counsel-recentf "Recentf" :exit t)
("s" save-buffer "Save" :exit t)
("q" nil)
)


;;counsel
(defhydra hydra-counsel (:color red :hint nil)
  "Counsel"
  ("i" counsel-imenu "Menu" :exit t)
  ("t" counsel-org-tag "Tags" :exit t)
  ("s" swiper "Swiper" :exit t)
  ("b" ivy-bibtex "Bibtex" :exit t)
  )

(defhydra hydra-org (:color red :hint nil :columns nil)
	    "
	    ^Agenda^             ^Other^      
	    -----------------------------------
	    _e_ : Dispatch         _v_ : Preview
	    _c_ : Capture     
	    _i_ : ClockIn     
	    _o_ : ClockOut	  
	    "
	    ("c" org-capture :exit t)
	    ("e" org-export-dispatch :exit t)
	    ("i" org-clock-in :exit t)
	    ("o" org-clock-out :exit t)
	    ("j" org-goto :exit t)
	    ("p" org-open-at-point :exit t)
	    ("t" org-insert-structure-template :exit t)
	    ("v" org-latex-preview :exit t)
	    ("q" nil)
	    )
(defhydra hydra-org-ref (:color red :hint nil :columns nil)
	  "
	  Org-ref
	  "
	  ("p" org-ref-open-bibtex-pdf "OpenPdf" :exit t)
	  ("n" org-ref-open-bibtex-notes "OpenNotes" :exit t)
	  )
(defhydra hydra-org-brain (:color red :hint nil :columns nil)
	  "
	  Org-Brain
	  "
	  ("v" org-brain-visualize "Visualize" :exit t)
	  ("m" org-brain-visualize-mind-map "MindMap" :exit t)
	    )
;;窗口管理
(defhydra hydra-window (:color red :columns nil)
	  "window"
	  ("/" split-window-right "Vertical":exit t)
	  ("-" split-window-below "Horizontal" :exit t)
	  ("d" delete-window "Delete" :exit t)
	  ("m" toggle-frame-maximized "Maximized" :exit t)
	  ("M" toggle-frame-fullscreen "FullScreen" :exit t)
	  ("q" nil "Quit")
	  )
;;Yasnippet
(defhydra hydra-yasnippet (:color red :hint nil)
	    "Yasnippet"
	      ("i" yas-insert-snippet "Insert" :exit t)
	        ("n" yas-new-snippet "New" :exit t)
		  ("r" yas-reload-all "Reload" :exit t)
		    ("q" nil)
		    )
(defhydra hydra-counsel (:color red :hint nil)
	    "Counsel"
	      ("i" counsel-imenu "Menu" :exit t)
	        ("t" counsel-org-tag "Tags" :exit t)
		  ("s" swiper "Swiper" :exit t)
		    ("b" ivy-bibtex "Bibtex" :exit t)
		      )

;;leader key
(general-create-definer my-space-leader-def
  :prefix "SPC"
  :non-normal-prefix "M-SPC"
  :states '(normal insert visual emacs))
(my-space-leader-def
 "SPC" 'counsel-M-x
 "1"   'select-window-1
 "2"   'select-window-2
 "3"   'select-window-3
 "4"   'select-window-4
 "b"   'hydra-buffer/body
 "f"   'hydra-file/body
 "c"   'hydra-counsel/body
 "j"   'jump-to-register
 "m"   'menu-bar-mode
 "M"   'toggle-frame-fullscreen
 "r"   'restart-emacs
 "w"   'hydra-window/body
 "y"   'hydra-yasnippet/body


 )


(set-register ?j '(file . "~/Nextcloud/W.PhD.20200424.Research/ResearchJournal.org"))
(set-register ?l '(file . "~/Nextcloud/W.PhD.20200424.Research/LabBook.org"))
(set-register ?d '(file . "~/Nextcloud/Brain/N.2020年.org"))
(set-register ?i '(file . "~/Nextcloud/W.PhD.20170901.Bibliography/0FilesStructure.org"))
(set-register ?n '(file . "~/Nextcloud/W.PhD.20170901.Bibliography/ReferenceReadingNotes.org"))
(set-register ?b '(file . "~/Nextcloud/Li.Beancount/2020.beancount"))
(provide 'init-key)
