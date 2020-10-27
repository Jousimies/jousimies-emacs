(require 'evil)
(require 'hydra)
(require 'general)
(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(setq-default
   evil-want-C-d-scroll t
   evil-want-C-u-scroll t )
;;开启evil模式
(evil-mode 1)
;;光标颜色
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
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
 "b"   'hydra-buffer/body
 "f"   'hydra-file/body
 "c"   'hydra-counsel/body
)


(provide 'init-key)
