(use-package vterm
  :ensure nil ;; Installed via Guix
  :bind ("C-c v" . vterm)
  :config
  (setq vterm-max-scrollback 10000)
  (add-hook 'vterm-mode-hook
            (lambda ()
              (set-process-query-on-exit-flag (get-buffer-process (current-buffer)) nil))))


(defun my/vterm-save-data (desktop-dirname)
  "Save the vterm buffer name for restoration."
  (list (buffer-name)))

(defun my/vterm-restore (filename buffer-name misc)
  "Restore a vterm buffer. If the buffer is dead, respawn it."
  (if (get-buffer buffer-name)
      (get-buffer buffer-name)
    (vterm buffer-name)))

(add-to-list 'desktop-buffer-mode-handlers '(vterm-mode . my/vterm-restore))

(add-hook 'vterm-mode-hook
          (lambda () (setq-local desktop-save-buffer 'my/vterm-save-data)))


(setq desktop-load-locked-desktop t)
(setq desktop-restore-eager 5)
(setq desktop-restore-frames nil) 
(setq desktop-auto-save-timeout 60)

(defun my/save-on-disconnect (frame)
  (when (daemonp)
    (when (file-exists-p (desktop-full-file-name))
      (desktop-save-in-desktop-dir))))

(add-hook 'delete-frame-functions #'my/save-on-disconnect)

(defun my/setup-client-window ()
  "Force layout: Work Top, Vterm Bottom, Treemacs Side."
  (run-with-timer 0.1 nil
                  (lambda ()
                    (unless (bound-and-true-p my--session-restored)
                      (setq my--session-restored t)
                      (desktop-save-mode 1)
                      (condition-case nil (desktop-read) (error nil)))
                    
                    (let* ((term-buf (seq-find (lambda (b) 
                                                 (with-current-buffer b (eq major-mode 'vterm-mode))) 
                                               (buffer-list)))
                           (work-buf (seq-find (lambda (b) 
                                                 (let ((n (buffer-name b)))
                                                   (and (not (string-prefix-p " " n))
                                                        (not (string-prefix-p "*" n))
                                                        (not (eq (with-current-buffer b major-mode) 'vterm-mode)))))
                                               (buffer-list))))

                      (delete-other-windows)

                      (if work-buf 
                          (switch-to-buffer work-buf)
                        (switch-to-buffer "*scratch*"))

                      (when term-buf
                        (let ((top-win (selected-window))
                              (bot-win (split-window-below))) 
                          (select-window bot-win)
                          (switch-to-buffer term-buf)
                          
                          (let ((target-height 15)
                                (current-height (window-height bot-win)))
                            (when (> current-height target-height)
                              (window-resize bot-win (- target-height current-height) nil)))
                          
                          ;; Go back to top window
                          (select-window top-win)))
                      
                      (unless (treemacs-get-local-window)
                        (treemacs))))))

(if (daemonp)
    (add-hook 'server-after-make-frame-hook #'my/setup-client-window)
  ;;  standalone (not daemon), just start desktop mode
  (desktop-save-mode 1))


(provide 'layout)
