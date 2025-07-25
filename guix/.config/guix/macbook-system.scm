;;; Core GNU modules and system definitions
(use-modules (gnu))

;;; Third-party and non-free modules
(use-modules
 (gchannel packages mac-compat-kernel)
)

(operating-system
  (inherit (base-operating-system))
  (kernel linux-kernel-mbp-t2)
  (host-name "GuixMac")

  (initrd-modules (append '("applespi" "bcm5974") %base-initrd-modules))
  (swap-devices
   (list
	   (swap-space (target (uuid "cd232ce0-e15a-4df9-a6e0-0ac23f42eae8")))))
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
                         (type "vfat")) %base-file-systems)))
