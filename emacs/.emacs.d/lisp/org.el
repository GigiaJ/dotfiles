(org-babel-do-load-languages
 'org-babel-load-languages
 '((clojure . t)))

(setq org-babel-clojure-backend 'cider)
(setq org-confirm-babel-evaluate nil)

(defun my/org-eval-only-if-allowed ()
  (when (eq major-mode 'org-mode)
    (org-babel-map-src-blocks nil
      (let* ((info (org-babel-get-src-block-info 'light))
             (params (nth 1 info)))
        (when (string= (cdr (assoc :eval params)) "yes")
          (org-babel-execute-src-block))))))

(add-hook 'after-save-hook #'my/org-eval-only-if-allowed)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Journal"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n d" . org-roam-dailies-capture-today))
  :config

  (org-roam-db-autosync-mode))

 (setq org-roam-dailies-capture-templates
      '(("dev" "Dev Note" plain "* Problem\n\n%?* Solution\n\n* Notes\n"
         :target (file+head "dev/daily/journal/${date}.org"
                            "#+title: %<%Y.%m.%d>\n#+filetags: dev\n")
         :unnarrowed t)

        ("work" "Work Note" plain "* Tasks\n\n%?* Meetings\n\n* Log\n"
         :target (file+head "work/daily/journal/${date}.org"
                            "#+title: %<%Y.%m.%d>\n#+filetags: work\n")
         :unnarrowed t)

        ("personal" "Personal Note" plain "* Journal\n%?"
         :target (file+head "personal/daily/journal/${date}.org"
                            "#+title: %<%Y.%m.%d>\n#+filetags: personal\n")
         :unnarrowed t)))


(provide 'org)