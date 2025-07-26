;;; Core GNU modules and system definitions
(use-modules (gnu)
             (gnu system)      ; For G (gigabytes)
             (guix services))  ; For swap-file-service-type

;;; Third-party and non-free modules
(use-modules
 (gchannel packages mac-compat-kernel)
)

(operating-system
  (inherit (base-operating-system))
  (kernel linux-kernel-mbp-t2)
  (host-name "GuixMac")

  (initrd-modules (append '("applespi" "bcm5974") %base-initrd-modules))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                  (keyboard-layout (keyboard-layout "us"))))
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "fda1c5ce-fb5b-49f7-a925-80511ffe4785"
                                  'btrfs))
                         (type "btrfs"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "5F66-17ED"
                                       'fat32))
                         (type "vfat")) %base-file-systems))

  ;; Add a service to create and manage a swap file.
  (services (cons* (service swap-file-service-type
                            (swap-file-configuration
                              ;; The path where the swap file will be created.
                              (target "/swapfile")

                              ;; The desired size. Adjust as needed.
                              (size (* 16 G))))
                   %base-services)))