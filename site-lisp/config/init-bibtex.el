(require 'helm-bibtex)
(require 'org-ref)


(find-file "~/Nextcloud/W.PhD.20170901.Bibliography/Reference.bib")
(global-set-key (kbd "<f11>") 'helm-bibtex)

(setq bibtex-completion-bibliography "~/Nextcloud/W.PhD.20170901.Bibliography/Reference.bib"
      bibtex-completion-library-path "~/Nextcloud/W.PhD.20170901.Bibliography/PDFs"
      bibtex-completion-notes-path "~/Nextcloud/W.PhD.20170901.Bibliography/ReferenceReadingNotes.org")

(setq bibtex-completion-additional-search-fields '(groups))
(setq bibtex-completion-pdf-field "file")
(setq bibtex-completion-pdf-symbol "P")
(setq bibtex-completion-notes-symbol "N")

(setq bibtex-completion-display-formats
      '((t . "${author:10} ${year:4} ${=has-pdf=:1} ${=has-note=:1} ${=type=:7} ${title:*}")))

(setq org-ref-bibliography-notes "~/Nextcloud/W.PhD.20170901.Bibliography/ReferenceReadingNotes.org"
      org-ref-default-bibliography '("~/Nextcloud/W.PhD.20170901.Bibliography/Reference.bib")
      org-ref-pdf-directory "~/Nextcloud/W.PhD.20170901.Bibliography/PDFs/")
(setq org-ref-show-broken-links nil)
(setq bibtex-completion-pdf-open-function 'org-open-file)

(defun my/org-ref-notes-function (candidates)
    (let ((key (helm-marked-candidates)))
          (funcall org-ref-notes-function (car key))))

(helm-delete-action-from-source "Edit notes" helm-source-bibtex)
(helm-add-action-to-source "Edit notes" 'my/org-ref-notes-function helm-source-bibtex 7)



(provide 'init-bibtex)
