;;; Core GNU modules and system definitions
(use-modules (gnu)
             (gnu system)
             (gnu services)
            ) 

;;; Third-party and non-free modules
(use-modules
  (gchannel packages mac-compat-kernel)
  (nongnu packages linux)
  (t2-wifi-firmware)
)

(operating-system
  (inherit (base-operating-system))
  (firmware (list t2-wifi-firmware linux-firmware))
  (kernel linux-kernel-mbp-t2)
  (host-name "GuixMac")
  (swap-devices
   (list
	   (swap-space (target (uuid "8cf21ad7-dc47-43ab-a2c6-5b429d20ccaf")))))
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
                  )