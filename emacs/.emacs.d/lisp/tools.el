(load "~/.emacs.d/.gptel-keys.el" t)

(use-package gptel
  :ensure t
  :config
  (setq gptel-backend
        (gptel-make-gemini
         "Gemini"
         :key gptel-gemini-api-key)))

(setq gptel-model 'gemini-2.5-flash)


(use-package treemacs
  :ensure t
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-git-mode 'deferred)
  (treemacs-project-follow-mode t))


(defun my/init-eaf ()
  "Load EAF only when graphical frame is ready"
  (require 'eaf)
  (require 'eaf-browser)
  )

(if (daemonp)
    ;; If daemon, wait for the first client frame
    (add-hook 'server-after-make-frame-hook #'my/init-eaf)
  ;; standalone, no wait
  (my/init-eaf))


(provide 'tools)
