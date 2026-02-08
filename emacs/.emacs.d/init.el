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

(org-babel-do-load-languages
 'org-babel-load-languages
 '((clojure . t)))

(setq org-babel-clojure-backend 'cider)

(defun my/org-eval-only-if-allowed ()
  (when (eq major-mode 'org-mode)
    (org-babel-map-src-blocks nil
      (let* ((info (org-babel-get-src-block-info 'light))
             (params (nth 2 info)))
        (when (string= (cdr (assoc :eval params)) "yes")
          (org-babel-execute-src-block))))))

(add-hook 'after-save-hook #'my/org-eval-only-if-allowed)


(load "~/.emacs.d/.gptel-keys.el" t)

(setq org-confirm-babel-evaluate nil)

(use-package gptel
  :ensure t
  :config
  (setq gptel-backend
        (gptel-make-gemini
         "Gemini"
         :key gptel-gemini-api-key)))

 (setq gptel-model 'gemini-2.5-flash)

(doom-modeline-mode 1)

(defun my-show-nav-cheat-sheet ()
  "Display a small cheat sheet for Emacs navigation commands."
  (interactive)
  (with-help-window (current-buffer) ; Display in a temporary help-like window
    (insert
     "--- Emacs Navigation Cheat Sheet ---\n"
     "\n"
     "WINDOWS (visible panes):\n"
     "C-x o           - Move cursor to the next window.\n"
     "C-x 0           - Close current window.\n"
     "C-x 1           - Close all other windows, keep current.\n"
     "C-x 2           - Split window top/bottom.\n"
     "C-x 3           - Split window left/right.\n"
     "\n"
     "BUFFERS (open files/modes):\n"
     "C-x b           - Prompt to switch to a specific buffer.\n"
     "C-x C-b         - Show a list of all open buffers.\n"
     "C-x <left>      - Go to the previously used buffer.\n"
     "C-x <right>     - Go to the next used buffer.\n"
     "\n"
     "Other useful:\n"
     "C-g             - Cancel current command/input.\n"
     "M-x <command>   - Run any Emacs command by name (e.g., M-x save-buffer).\n"
     "------------------------------------\n"
     "C-c r to enter/exit our resize mode\n"

     "M-x gptel - Useful to ask more detailed questions about using Emacs\n"
     "The goal is to ease into using Emacs and then take the training wheels off\n"
     "Q should close this window\n"
     )))

(global-set-key (kbd "M-m") 'my-show-nav-cheat-sheet)
(global-set-key (kbd "C-M-S-<left>")  #'shrink-window-horizontally)
(global-set-key (kbd "C-M-S-<right>") #'enlarge-window-horizontally)
(global-set-key (kbd "C-M-S-<down>")  #'shrink-window)
(global-set-key (kbd "C-M-S-<up>")    #'enlarge-window)
