;;; Core GNU modules and system definitions
(use-modules (gnu)
                         ((nongnu packages linux) #:select (linux)))

(operating-system
  (inherit (base-operating-system))
  (kernel linux)
  (host-name "Catdog7")

  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot"))
               (menu-entries (list
                              (menu-entry
                               (label "GParted")
                               (device (uuid "2025-01-30-22-09-48-00" 'iso9660))
                               (chain-loader "/EFI/boot/grubx64.efi"))
                              (menu-entry
                               (label "Arch Linux")
                               (device (uuid "2755-7752" 'fat))
                               (chain-loader "/EFI/arch/grubx64.efi"))
                              (menu-entry
                               (label "Windows")
                               (device (uuid "F204-F2E2" 'fat))
                               (chain-loader "/EFI/Microsoft/Boot/bootmgrw.efi"))))
               (keyboard-layout (keyboard-layout "us"))))

  (file-systems (cons*
                 ;; BTRFS root partition on the main NVMe drive.
                 (file-system
                  (mount-point "/")
                  (device (uuid "b9c6ca07-2d84-4730-8fb7-975f481bf36b"
                                'btrfs))
                  (type "btrfs"))
                 ;; Separate BTRFS partition on a secondary drive for games.
                 (file-system
                  (mount-point "/games")
                  (device (uuid "c3231cc4-d95f-4656-988d-24151ab48137"
                                'btrfs))
                  (type "btrfs"))
                 ;; Standard EFI boot partition.
                 (file-system
                  (mount-point "/boot")
                  (device (uuid "3621-68F9" 'fat))
                  (type "vfat"))
                 %base-file-systems)
                
                )
              
              )