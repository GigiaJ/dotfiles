;;; Core GNU modules and system definitions
(use-modules (gnu)
                         ((nongnu packages linux) #:select (linux)))

(operating-system
  (inherit (base-operating-system))
  (kernel linux)
  (host-name "Catdog7")

  (swap-devices
   (list
	   (swap-space (target (uuid "38e80242-7431-4623-9b0a-0b4836d1c74d")))))

  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot"))
               (menu-entries (list
                              (menu-entry
                               (label "GParted")
                               (device (uuid "2025-01-30-22-09-48-00" 'iso9660))
                               (chain-loader "/EFI/boot/grubx64.efi"))
                              (menu-entry
                               (label "Windows")
                               (device (uuid "F204-F2E2" 'fat))
                               (chain-loader "/EFI/Microsoft/Boot/bootmgrw.efi"))))
               (keyboard-layout (keyboard-layout "us"))))

  (file-systems (cons*
                 ;; BTRFS root partition on the main NVMe drive.
                 (file-system
                  (mount-point "/")
                  (device (uuid "be852cc7-cdfa-4afb-b2b6-b826d7ebe6d9"
                                'btrfs))
                  (type "btrfs"))
                 ;; Separate BTRFS partition on a secondary drive for games.
                 (file-system
                  (mount-point "/games")
                  (device (uuid "c3231cc4-d95f-4656-988d-24151ab48137"
                                'btrfs))
                  (type "btrfs"))
		 ;; Home BTRFS partition
		 (file-system
		  (mount-point "/home")
		  (device (uuid "9b0838b9-b9d1-467e-aaeb-ef1de89f67ad"
			'btrfs))
		  (type "btrfs"))
                 ;; Standard EFI boot partition.
                 (file-system
                  (mount-point "/boot")
                  (device (uuid "630D-EA49" 'fat))
                  (type "vfat"))
                 %base-file-systems)))
