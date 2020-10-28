;;; Code:

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

(provide 'init-org)