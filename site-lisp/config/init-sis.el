(require 'sis)
(setq sis-follow-context-fixed 'other)
(sis-ism-lazyman-config "1033" "2052" 'im-select)
;; enable the /cursor color/ mode
(sis-global-cursor-color-mode t)
;; enable the /respect/ mode
(sis-global-respect-mode t)
;; enable the /follow context/ mode for all buffers
(sis-global-follow-context-mode t)

(provide 'init-sis)
