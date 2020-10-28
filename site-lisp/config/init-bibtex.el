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


(provide 'init-bibtex)
