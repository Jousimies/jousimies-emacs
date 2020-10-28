;;加速设置
(require 'init-accelerate)

;;字体设置
(require 'init-font)

(let (
      ;; 加载的时候临时增大`gc-cons-threshold'以加速启动速度。
      (gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      ;; 清空避免加载远程文件的时候分析文件。
      (file-name-handler-alist nil))

  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			    ("melpa" . "http://elpa.emacs-china.org/melpa/")))
; 定义一些启动目录，方便下次迁移修改
  (defvar jousimies-emacs-root-dir (file-truename "~/jousimies-emacs/site-lisp"))
  (defvar jousimies-emacs-config-dir (concat jousimies-emacs-root-dir "/config"))
  (defvar jousimies-emacs-extension-dir (concat jousimies-emacs-root-dir "/extensions"))

  (with-temp-message ""
        ;抹掉插件启动的输
    (require 'benchmark-init-modes)
    (require 'benchmark-init)
    (benchmark-init/activate)
    (require 'init-startup)
    (require 'init-generic)
    (require 'init-theme)
    (require 'init-awesome-tray)
    ;;(require 'init-awesome-tab)
    (require 'init-backup)
    (require 'init-line-number)
    (require 'init-auto-save)
    ;;(require 'lazy-load)
    ;;(require 'one-key)
    ;;(require 'awesome-pair)
    ;;(require 'init-git)
    (require 'init-key)
    (require 'ivy)
    (require 'counsel)
    ;;(require 'magit)
    (require 'init-org)
    (require 'init-bibtex)




    )



)






(provide 'init)
