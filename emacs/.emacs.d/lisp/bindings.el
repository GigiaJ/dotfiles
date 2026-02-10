(defun my-show-nav-cheat-sheet ()
  "Display a small cheat sheet for Emacs navigation commands."
  (interactive)
  (with-help-window (current-buffer)
    (insert
     "--- Emacs Navigation Cheat Sheet ---\n"
     "\n"
     "WINDOWS (visible panes):\n"
     "C-x o            - Move cursor to the next window.\n"
     "C-x -1           - Close current window.\n"
     "C-x 0            - Close all other windows, keep current.\n"
     "C-x 1            - Split window top/bottom.\n"
     "C-x 2            - Split window left/right.\n"
     "\n"
     "BUFFERS (open files/modes):\n"
     "C-x b            - Prompt to switch to a specific buffer.\n"
     "C-x C-b          - Show a list of all open buffers.\n"
     "C-x <left>       - Go to the previously used buffer.\n"
     "C-x <right>      - Go to the next used buffer.\n"
     "\n"
     "Other useful:\n"
     "C-g              - Cancel current command/input.\n"
     "M-x <command>    - Run any Emacs command by name.\n"
     "------------------------------------\n"
     "M-x gptel - Ask AI for help\n"
     "Q should close this window\n")))

(global-set-key (kbd "M-m") 'my-show-nav-cheat-sheet)

;; Window resizing
(global-set-key (kbd "C-M-S-<left>")  #'shrink-window-horizontally)
(global-set-key (kbd "C-M-S-<right>") #'enlarge-window-horizontally)
(global-set-key (kbd "C-M-S-<down>")  #'shrink-window)
(global-set-key (kbd "C-M-S-<up>")    #'enlarge-window)

;; Terminal-friendly mouse support
(unless (display-graphic-p)
  (xterm-mouse-mode 1))


(provide 'bindings)
