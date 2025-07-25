(let ((f (current-filename)))
  (if f
      (add-to-load-path (dirname f))
      (display "Warning: current-filename returned #f\n")))

;; Now you can import your custom module without error.
(use-modules (utils))
(use-modules (base-system))
;; The rest of your logic remains the same.
(if (apple-hardware?)
    (load "macbook-config.scm")
    (load "desktop-system.scm"))