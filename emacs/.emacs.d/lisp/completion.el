(use-package vertico :init (vertico-mode))
(use-package orderless
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult)
(global-set-key (kbd "C-p") #'consult-find)

(setq ispell-program-name "hunspell")
(setq ispell-local-dictionary "en_US")
(setq ispell-local-dictionary-alist
      '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))

;; Enable Flyspell for text (Markdown, Org, Text files)
(add-hook 'text-mode-hook 'flyspell-mode)

;; Enable Flyspell for code (comments and strings only)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(provide 'completion)
