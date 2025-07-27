(let ((f (current-filename)))
  (if f
      (add-to-load-path (dirname f))
      (display "Warning: current-filename returned #f\n")))

(use-modules (utils))
(use-modules (base-system))
(if (apple-hardware?)
    (load "macbook-system.scm")
    (load "desktop-system.scm"))