(define-module (base-system)
  ;;; Core GNU modules
  #:use-module (gnu)

  ;;; Package definitions
  #:use-module ((gnu packages shells) #:select (zsh))
  #:use-module ((gnu packages gnome) #:select (network-manager-openvpn))
  #:use-module ((gnu packages linux) #:select (v4l2loopback-linux-module))
  #:use-module ((gnu packages display-managers) #:select (guix-simplyblack-sddm-theme))
  #:use-module ((gnu packages games) #:select (steam-devices-udev-rules))
  #:use-module ((gnu packages version-control) #:select (git))
  #:use-module ((gnu packages package-management) #:select (stow))


  ;;; Service definitions
  #:use-module ((gnu services docker) #:select (containerd-service-type docker-service-type))
  #:use-module ((gnu services desktop) #:select (gnome-desktop-service-type bluetooth-service-type kwallet-service-type %desktop-services))
  #:use-module ((gnu services sddm) #:select (sddm-service-type sddm-configuration))
  #:use-module ((gnu services xorg) #:select (gdm-service-type))
  #:use-module ((gnu services ssh) #:select (openssh-service-type))
  #:use-module ((gnu services networking) #:select (network-manager-service-type network-manager-configuration))
  #:use-module ((gnu services virtualization) #:select (libvirt-service-type libvirt-configuration))

  ;;; Third-party and non-free modules
  #:use-module ((gunit packages xdg-desktop-portal-hyprland-input-capture))
  #:use-module ((gunit packages linux))
  #:use-module ((nongnu packages linux) #:select (linux linux-firmware amdgpu-firmware))
  #:export (base-operating-system))

(define (base-operating-system)

(operating-system
  (firmware (list linux-firmware amdgpu-firmware))
    (locale "en_US.utf8")
  (timezone "America/Chicago")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "anything")
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot"))))

  (file-systems
   (cons*
    ;; Root partition
    (file-system
     (mount-point "/")
     (device (uuid "00000000-0000-0000-0000-000000000000" 'btrfs)) ; replace with actual UUID
     (type "btrfs"))

    ;; Games partition
    (file-system
     (mount-point "/games")
     (device (uuid "11111111-1111-1111-1111-111111111111" 'btrfs)) ; replace with actual UUID
     (type "btrfs"))

    ;; EFI Boot partition
    (file-system
     (mount-point "/boot")
     (device (uuid "2222-2222" 'fat)) ; replace with actual UUID
     (type "vfat"))

    %base-file-systems))

  (kernel-loadable-modules (list v4l2loopback-linux-module))

  (users (cons* (user-account
                 (name "jaggar")
                 (comment "Jaggar")
                 (group "users")
                 (home-directory "/home/jaggar")
                 (shell (file-append zsh "/bin/zsh"))
                 (supplementary-groups '("docker" "wheel" "netdev" "audio" "video" "input" "libvirt")))
                %base-user-accounts))
  (packages
    (append
     (map specification->package '( "hyprland-input-capture" "git" "stow" "guix-simplyblack-sddm-theme")) 
      %base-packages))

    (services
    (cons*
     (service sddm-service-type	(sddm-configuration	(theme "guix-simplyblack-sddm")))
     (service containerd-service-type)
     (service docker-service-type)
     (service openssh-service-type)
     (service bluetooth-service-type)
     (service kwallet-service-type)
     (service libvirt-service-type
      (libvirt-configuration
      (unix-sock-group "libvirt")))
    ;; Add udev rules for Steam controllers and other hardware.
     (udev-rules-service 'steam-devices steam-devices-udev-rules)
    ;; Raise the open file descriptor limits. This prevents errors in applications
    ;; that need to open many files, such as database servers or games running
    ;; through Wine/Proton.
     (service pam-limits-service-type (list (pam-limits-entry "*" 'soft 'nofile 65536) (pam-limits-entry "*" 'hard 'nofile 262144)))
    ;;(service gnome-keyring-service-type)
    ;; Modify the default desktop services to add OpenVPN support
    ;; directly into NetworkManager.
    ;; Otherwise we can't use our VPN config files.
    (modify-services %desktop-services
        (delete gdm-service-type)
        (network-manager-service-type config =>
        (network-manager-configuration
        (inherit config)
        (vpn-plugins (list network-manager-openvpn)))))))
))
