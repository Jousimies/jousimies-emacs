新建.emacs。
添加

'''Elisp
(defun add-subdirs-to-load-path (dir)
    "Recursive add directories to `load-path'."
      (let ((default-directory (file-name-as-directory dir)))
	    (add-to-list 'load-path dir)
	        (normal-top-level-add-subdirs-to-load-path)))
(add-subdirs-to-load-path "~/jousimies-emacs/site-lisp/")

(require 'init)
'''
