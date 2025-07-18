;;; Core GNU modules and system definitions
(use-modules (gnu))

;;; Package definitions
(use-modules
 ((gnu packages shells) #:select (zsh))
 ((gnu packages gnome) #:select (network-manager-openvpn))
 ((gnu packages linux) #:select (v4l2loopback-linux-module))
 ((gnu packages games) #:select (steam-devices-udev-rules)))

;;; Service definitions
(use-modules
 ((gnu services docker) #:select (containerd-service-type docker-service-type))
 ((gnu services desktop) #:select (gnome-desktop-service-type bluetooth-service-type gnome-keyring-service-type %desktop-services))
 ((gnu services pm) #:select (power-profiles-daemon-service-type))
 ((gnu services xorg) #:select (gdm-service-type))
 ((gnu services ssh) #:select (openssh-service-type))
 ((gnu services networking) #:select (network-manager-service-type network-manager-configuration)))

;;; Third-party and non-free modules
(use-modules
 (gchannel packages xdg-desktop-portal-hyprland-input-capture)
 (gchannel packages mac-compat-kernel)
 ((nongnu packages linux) #:select (linux linux-firmware amdgpu-firmware)))

(operating-system
  (kernel linux-kernel-mbp-t2)
  (firmware (list linux-firmware amdgpu-firmware))
    (locale "en_US.utf8")
  (timezone "America/Chicago")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "GuixMac")

  (kernel-loadable-modules (list v4l2loopback-linux-module))
  (initrd-modules (append '("applespi" "bcm5974") %base-initrd-modules))
  (swap-devices
   (list
	   (swap-space (target (uuid "cd232ce0-e15a-4df9-a6e0-0ac23f42eae8")))))

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                 (name "jaggar")
                 (comment "Jaggar")
                 (group "users")
                 (home-directory "/home/jaggar")
                 (shell (file-append zsh "/bin/zsh"))
                 (supplementary-groups '("docker" "wheel" "netdev" "audio" "video" "input")))
                %base-user-accounts))
  (packages
    (append
     (map specification->package '( "hyprland-input-capture")) 
      %base-packages))

(services
 (cons*
  (service containerd-service-type)
  (service docker-service-type)
  (service openssh-service-type)
  (service bluetooth-service-type)
  (service power-profiles-daemon-service-type)
  ;; Add udev rules for Steam controllers and other hardware.
  (udev-rules-service 'steam-devices steam-devices-udev-rules)
  ;; Raise the open file descriptor limits. This prevents errors in applications
  ;; that need to open many files, such as database servers or games running
  ;; through Wine/Proton.
  (service pam-limits-service-type
          (list
          (pam-limits-entry "*" 'soft 'nofile 65536)
          (pam-limits-entry "*" 'hard 'nofile 262144)))
  (service gnome-keyring-service-type)
  ;; Modify the default desktop services to add OpenVPN support
  ;; directly into NetworkManager.
  ;; Otherwise we can't use our VPN config files.
  (modify-services %desktop-services
    (network-manager-service-type config =>
      (network-manager-configuration
       (inherit config)
       (vpn-plugins (list network-manager-openvpn)))))))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

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
