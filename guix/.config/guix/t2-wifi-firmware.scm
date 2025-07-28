;;; T2 Wi-Fi Firmware (Proprietary)
;;;
;;; NOTE: These files are not committed to this repository due to licensing.
;;; To rebuild this configuration on a new machine, the following files
;;; must be extracted from MacOS and placed in
;;; /home/your-user/.config/t2-wifi-firmware/lib/firmware/brcm/
;;;
;;; REQUIRED FILES:
;;; - brcmfmac4364b3-pcie.bin
;;; - brcmfmac4364b3-pcie.clm_blob
;;; - brcmfmac4364b3-pcie.txt
;;;
;;; Additionally, these names are targeted to my specific release so some changes might 
;;; be needed.
;;;
(define-public t2-wifi-firmware
  (package
    (name "t2-wifi-firmware-local")
    (version "1.0.0")
    (source
      (local-file "/home/jaggar/.config/t2-wifi-firmware/lib/firmware/brcm/"
                  #:recursive? #t))
    (build-system trivial-build-system)
    (arguments
      `(#:install-plan
        '(("." "/"))))
    (synopsis "Locally sourced Wi-Fi firmware for Apple T2 Macs")
    (description synopsis)
    (license #f)))