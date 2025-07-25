(define-module (utils)
    #:use-module (ice-9 exceptions)
    #:use-module (ice-9 rdelim)
    #:use-module (srfi srfi-13)
    #:export (apple-hardware?)
)

(define (apple-hardware?)
  "Return #t if the DMI system vendor is Apple, otherwise #f.
   This is the correct way to check for a Mac running Guix System (Linux)."
  (catch #t ;; Catch any errors (e.g., file not found)
    (lambda ()
      (call-with-input-file "/sys/class/dmi/id/sys_vendor"
        (lambda (port)
          ;; Read the vendor string, trim whitespace, and check if it's "Apple Inc."
          (let ((vendor (string-trim (read-line port))))
            (string-prefix? "Apple" vendor)))))
    ;; In case of any error (e.g., non-Linux system, permissions), return #f.
    (lambda args #f)))
