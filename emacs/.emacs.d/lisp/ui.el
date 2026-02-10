(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(winner-mode 1)
(doom-modeline-mode 1)

(use-package doom-themes
  :config
  (load-theme 'doom-one t))

(provide 'ui)