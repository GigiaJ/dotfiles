(add-to-list 'load-path "~/.guix-home/profile/share/emacs/site-lisp")
(let ((default-directory "~/.guix-home/profile/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'geiser)
(require 'org)
(require 'magit)
(require 'ement)
(require 'doom-modeline)
(require 'projectile)

(provide 'base)
