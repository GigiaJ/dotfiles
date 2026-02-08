(add-to-list 'load-path "~/.guix-home/profile/share/emacs/site-lisp")
(let ((default-directory "~/.guix-home/profile/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'eaf)
(require 'eaf-browser)
(require 'geiser)
(require 'org)
(require 'magit)
(require 'ement)
(require 'geiser)
(require 'doom-modeline)
(require 'doom-themes)
(require 'projectile)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(doom-city-lights))
 '(custom-safe-themes
   '("77fff78cc13a2ff41ad0a8ba2f09e8efd3c7e16be20725606c095f9a19c24d3d"
     "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69"
     "7ec8fd456c0c117c99e3a3b16aaf09ed3fb91879f6601b1ea0eeaee9c6def5d9"
     "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476"
     default))
 '(package-selected-packages '(deferred eaf eaf-browser epc spacemacs-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(doom-modeline-mode 1)
