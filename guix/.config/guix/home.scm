(use-modules (gnu home)
             (gnu home services)
             (gnu home services gnupg)
             (gnu home services shells)
             (gnu home services shepherd)
             (gnu home services sound)
             (gnu home services desktop)
             (gnu packages)
             (gnu services)
             (gnu system)
             (gnu system shadow)
             (nongnu packages)
             (gunit packages code-server)
             (gunit services ai)
             (selected-guix-works packages fonts)
             (gunit services code-server)
             (guix gexp))

(define %dev-packages
  (specifications->packages '("clojure" ;; A dynamic, general-purpose programming language, combining the approachability and interactive development of a scripting language with an efficient and robust infrastructure for multithreaded programming.
                              "openjdk:jdk" ;; The Java Development Kit, an implementation of the Java Platform, Standard Edition.
                              "leiningen" ;; A build automation and dependency management tool for the Clojure programming language.
                              "valgrind" ;; An instrumentation framework for building dynamic analysis tools that can be used to automatically detect memory management and threading bugs, and to profile your programs in detail.
                              "gdb" ;; The GNU Debugger, which allows you to see what is going on inside another program while it executes.
                              "gcc-toolchain" ;; The GNU Compiler Collection toolchain, which includes a set of programming language compilers.
                              "git" ;; A free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.
                              "strace" ;; A diagnostic, debugging, and instructional userspace utility for Linux to monitor system calls and signals.
                              "runc" ;; A CLI tool for spawning and running containers according to the OCI specification.
                              "cmake" ;; Cross-platform build system generator. Highly used in C and C++ projects.
                              "make" ;; Build automation tool that reads from a Makefile t compile and link programs. Highly used in C and C++ projects.
                              "python" ;; Provides the core interpreter and standard library for python so you might run python programs...
                              ;; "ollama" 
                              ;;    "jupyter"                 ;; Interactive computing environment — runs notebooks with code, markdown, and visualizations. Modern replacement for Org-mode (probably).
                              ;;    "python-jupytext"         ;; Syncs Jupyter notebooks with plain text formats like Markdown or Python scripts.
                              ;;   "python-jupyter-console"  ;; Terminal-based console for Jupyter kernels — lets you interact with Python and other languages.
                              "gnupg"

                              "emacs"
                              "emacs-eaf"
                              "emacs-eaf-browser")))

(define %program-packages
  (append (specifications->packages '( ;; Work requirements
                                       "microsoft-edge-stable" ;; The stable release of Microsoft's Edge web browser.
                                      "azure-cli" ;; CLI to interface w/ Azure resources
                                      
                                      ;; General purpose
                                      ;;  "deskflow"                ;; A productivity application designed to help you manage your tasks and workflows.
                                      ;; "librewolf" ;; An independent fork of Firefox, with the primary goals of privacy, security, and user freedom.
                                      "floorp" ;; A fork of Firefox that is more customizable and has more features than the original. It has PWAs baked in.
                                      ;;   "steam" ;; A video game digital distribution service by Valve.
                                      ;;    "neovim"                  ;; A hyperextensible, Vim-based text editor that’s backwards-compatible with Vim. We combo it with the extension in code-server/vscode.
                                      "vscodium" ;; A community-driven, freely-licensed binary distribution of Microsoft’s Visual Studio Code.
                                      ;;  "bolt-launcher" ;; A third-party launcher for Jagex accounts for the popular online game RuneScape and Old School RuneScape.
                                      "obs" ;; Open Broadcaster Software, a free and open-source software for video recording and live streaming.
                                      "obs-droidcam" ;; A plugin for OBS Studio that lets you use your phone as a camera source.
                                      ;;       "flatpak" ;; A system for building, distributing, and running sandboxed desktop applications on Linux.
                                      "openscad" ;; A software for creating solid 3D CAD objects.
                                      "conky" ;; A free, light-weight system monitor for X, that displays any kind of information on your desktop.
                                      ;; A service that allows you to run VS Code on any machine anywhere and access it in the browser.
                                      "nextcloud-client" ;; A self-host-able Cloud platform for files, communication, file-sharing, and collaboration. Super useful for syncing our home directory files like some would use OneDrive.
                                      "node" ;; Node.JS Interpreter and NPM
                                      ;;   "ollama" ;; A CLI tool to allow LLM (and other) model loading to provide to a front-end tool (or to use in the CLI)
                                      "pantalaimon"

"gobject-introspection" ;; for panta
"python-pygobject" ;; for panta
"gtk+"


;; emacs below
                                      "python-pyqt6-sip"

                                      "python-pyqtwebengine"
                                      "python-sip"
                                      "python-epc"
                                      "python-sexpdata"
                                      "emacs"
                                      "emacs-org"
                                      ;;  "emacs-eaf"
                                      "emacs-magit"
                                      "emacs-tramp"
                                      "emacs-projectile"
                                      "emacs-doom-themes"
                                      "emacs-doom-modeline"
                                      "emacs-treemacs"
                                      "emacs-lsp-mode"
                                      "emacs-ement"
                                      "emacs-eaf-browser"))
          (list (make-code-server-with-font code-server ;; A service that allows you to run VS Code on any machine anywhere and access it in the browser.
                                            font-nerd-fonts-jetbrains-mono ;; This particularly builds code-server with our chosen font (since it runs in the browser the fonts must be supplied in advance)
                                            "JetBrainsMonoNerdFontMono-"))))

(define %utility-packages
  (append (specifications->packages '("fmt" ;; A modern formatting library for C++, providing a fast and safe alternative to C-style printf.
                                      "ffmpeg" ;; A complete, cross-platform solution to record, convert and stream audio and video.
                                      "dpkg" ;; The package manager for Debian-based systems; handles installation, removal, and management of .deb packages.
                                      "pkg-config" ;; A helper tool used when compiling applications and libraries to retrieve information about installed libraries.
                                      "util-linux" ;; A standard package of essential Linux command-line utilities.
                                      "btrfs-progs" ;; A set of userspace utilities for managing Btrfs filesystems.
                                      "axel" ;; Light-weight command-line download accelerator.
                                      "playerctl" ;; Command-line controller for media players that support MPRIS (VLC, Spotify, etc)
                                      "cava" ;; Console-based audio visualizer. Displays music visualizations in your terminal.
                                      "jq" ;; Lightweight and powerful command-line JSON processor — perfect for parsing and manipulating JSON.
                                      "openssl" ;; Command line tool for tasks like generating public and private keys, encrypting files, testing SSL connections, and more.
                                      "procps" ;; A set of command-line and full-screen utilities that provide information out of the /proc filesystem, including `ps`, `top`, and `kill`.
                                      ))))

(define %lib-packages
  (append (specifications->packages '("libglvnd" ;; The GL Vendor-Neutral Dispatch library, which allows multiple OpenGL implementations to coexist on the same system.
                                      "libp11" ;; A library that provides a higher-level interface for PKCS#11, simplifying interaction with cryptographic hardware.
                                      "libx11" ;; The core X11 client library, providing the fundamental functions for interacting with an X server.
                                      "libxcb" ;; The X C Binding, a replacement for Xlib that provides a more modern and efficient way to communicate with the X server.
                                      "libxxf86vm" ;; The XFree86-VidModeExtension library, allowing for the manipulation of video modes.
                                      "libsm" ;; The X Session Management library.
                                      "zlib" ;; A software library used for data compression and decompression.
                                      "sdl2" ;; A cross-platform development library providing low-level access to audio, keyboard, mouse, joystick, and graphics hardware.
                                      "nss" ;; Network Security Services, a set of libraries designed to support cross-platform development of security-enabled client and server applications.
                                      "egl-wayland" ;; A library that allows EGL (a Khronos rendering API) to work with the Wayland display protocol.   
                                      "libappindicator" ;; A library that allows applications to export a menu to the system tray.
                                      "libdbusmenu-qt" ;; A Qt implementation for libdbusmenu, allowing Qt applications to create D-Bus menus.
                                      "libnotify" ;; A library for sending desktop notifications to a notification daemon.
                                      "libuv" ;; A library for async operations. Used especially in Node.js and Cmake.
                                      "tinyxml2" ;; A lightweight C++ XML parser. Just meant to be included as a .cpp and .h really.
                                      "yad" ;; Yet Another Dialog. Creates GTK+ dialog boxes from shell scripts.
                                      "vulkan-headers"
                                      "vulkan-loader"
                                      "mesa"
                                      "vulkan-tools"
                                      "python-requests" ;; Python library for HTTP requests — simple and elegant API for web interactions.
                                      "python-pyquery"))))

(define %general-packages
  (append (specifications->packages '("gdm" ;; The GNOME Display Manager, which provides graphical logins and manages display servers.
                                      "sddm" ;; The Simple Desktop Display Manager, a modern display manager for X11 and Wayland.
                                      "xhost" ;; A server access control program for X; it adds and deletes hostnames or user names to the list allowed to make connections to the X server.
                                      "xauth" ;; A utility for managing X authority files, which contain authentication information for connecting to an X server.
                                      "xinit" ;; A program that allows a user to manually start an Xorg display server.
                                      "xcb-util" ;; A collection of utility libraries for the X C Binding (XCB), making it easier to work with.
                                      "xorg-server" ;; The core X Window System display server.
                                      "wayland" ;; A communication protocol that specifies the communication between a display server and its clients.
                                      "amdgpu-firmware" ;; Firmware files required for AMD Radeon graphics cards to function correctly.
                                      "mediatek-firmware" ;; Firmware files for various MediaTek wireless and Bluetooth devices.
                                      "xf86-input-libinput" ;; An X.Org driver that uses the libinput library to provide generic input device support.
                                      "xf86-video-fbdev" ;; An X.Org driver for framebuffer devices, providing a basic video driver.
                                      "xf86-video-nouveau" ;; An open-source X.Org driver for NVIDIA graphics cards.
                                      "gtkmm" ;; The official C++ interface for the popular GUI library GTK.
                                      "gtk" ;; The GIMP Toolkit, a multi-platform toolkit for creating graphical user interfaces.
                                      "gdk-pixbuf" ;; A toolkit for image loading and pixel buffer manipulation, often used with GTK.
                                      "bluez" ;; The official Linux Bluetooth protocol stack; it provides the core Bluetooth functionality.
                                      "glibc-locales" ;; Provides locale data for glibc — enables language and regional settings.
                                      "lxqt-policykit" ;; PolicyKit authentication agent for LXQt desktop — handles privilege escalation prompts.
                                      
                                      ))))

(define %desktop-packages
  (append (specifications->packages '("hicolor-icon-theme" ;; A fallback icon theme that provides a standard directory structure for icon themes.
                                      "papirus-icon-theme" ;; Stylish and popular icon theme — supports many desktop environments.
                                      "adwaita-icon-theme" ;; GNOME’s default icon theme — clean and consistent.
                                      "gnome-themes-extra" ;; Provides extra themes for the GNOME desktop, including the popular Adwaita-dark.
                                      "breeze-icons" ;; Default icon theme for KDE Plasma — clean and modern.
                                      "qt6ct" ;; Configuration tools for Qt applications — lets you theme Qt apps outside KDE.
                                      "qt5ct" ;; Configuration tools for Qt applications — lets you theme Qt apps outside KDE.
                                      "bash" ;; Bourne Again shell (sh) with many improvements.
                                      "zsh" ;; An extended Bourne shell (sh) with many improvements. Tends to be a bit more feature rich than Bash.
                                      "network-manager-openvpn" ;; A plugin for NetworkManager to support OpenVPN connections.
                                      "waybar" ;; Provides a highly customizable Wayland bar for Sway and other wlroots-based compositors.
                                      "swaynotificationcenter" ;; A simple notification daemon for Sway/Wayland that displays notifications.
                                      "hyprland-protocols" ;; On input capture merge this can be reverted to hyprland-protocols
                                      "hyprutils" ;; Utility library used across the Hyprland ecosystem.
                                      "hyprwayland-scanner" ;; An implementation of wayland-scanner tailored for Hyprland.
                                      "hyprlang" ;; Configuration language parser for Hyprland, enabling the config file to be parsed and used.
                                      "hyprlock" ;; The official lock screen utility for the Hyprland compositor.
                                      "wayland-protocols" ;; A set of standard protocols for the Wayland display server system.
                                      "wl-clipboard" ;; Provides command-line copy and paste utilities for Wayland.
                                      "mako" ;; A lightweight notification daemon for Wayland.
                                      "blueman" ;; A full-featured Bluetooth manager that provides a graphical interface for managing Bluetooth devices.
                                      "pavucontrol" ;; A simple GTK-based volume control tool ("mixer") for PulseAudio.
                                      "nnn" ;; A fast and resource-sensitive terminal file manager.
                                      "wofi" ;; A launcher/menu program for wlroots-based Wayland compositors like Sway.
                                      "xdg-desktop-portal" ;; A framework that allows sandboxed applications to access resources outside their sandbox.
                                      "xdg-desktop-portal-hyprland" ;; Used to connect hyprland to the xdg-desktop-portal itself and declares certain privileges 'portals'. Should be reverted to just xdg-desktop-portal-hyprland when input-capture is merged.
                                      "slurp" ;; A command-line utility to select a region on a Wayland desktop.
                                      "grim" ;; A command-line screenshot tool for Wayland compositors.
                                      "xcb-util-cursor" ;; A utility library for the XCB library, providing convenience functions for cursor management.
                                      "dbus" ;; A message bus system, providing an easy way for applications to talk to one another.
                                      "pipewire" ;; A server and user space API to deal with multimedia pipelines.
                                      "wireplumber" ;; A session and policy manager for PipeWire.
                                      "font-google-noto" ;; The base Noto font family, designed for visual harmony across languages.
                                      "font-google-noto-serif-cjk" ;; Serif variant of Noto for Chinese, Japanese, and Korean scripts.
                                      "font-google-noto-sans-cjk" ;; Sans-serif variant of Noto for CJK scripts.
                                      "font-google-noto-emoji" ;; The emoji font from the Noto family, providing full-color emoji support.
                                      "font-nerd-fonts" ;; A collection of patched fonts with icons (Devicons, Font Awesome, etc.) for use in terminals and status bars.
                                      "rofi" ;; An application launcher. For us it is used alongside hyperland.
                                      "wlogout" ;;
                                      "wallust" ;; A fast wallpaper color scheme generator. Can theme your system based on your current wallpaper.
                                      "swww" ;; A Wayland wallpaper daemon that supports animated wallpapers, transitions, and per monitor wall papers. Not currently using, but should.
                                      "hyprpaper" ;; A wallpaper manager (daemon included) for Hyprland (Wayland compositor) supports per monitor wall papers and IPC control. Currently using. (They will not add animated wallpapers). Simplicity in mind.
                                      "ark" ;; KDE archive manager — handles zip, tar, rar, and other formats.
                                      "mousepad" ;; Lightweight text editor for Xfce — simple and fast.
                                      "btop" ;; Modern resource monitor — shows CPU, memory, disk, and network usage with a slick UI.
                                      "kitty" ;; GPU-based terminal emulator — fast, feature-rich, and highly customizable.
                                      ;; Not currently in active use
                                      "power-profiles-daemon" ;; Manages power profiles (balanced, pe rformance, power-saver) on Linux systems.
                                      "kwallet" ;; Secure storage for passwords and keys, integrated with KDE.
                                      "dolphin" ;; File explorer with a lovely interface and deep feature set.
                                      "ksshaskpass" ;; Front-end for ssh-add to store passwords of SSH key into KWallet.
                                      "kwallet-pam" ;;
                                      "qtwayland" ;;
                                      "qt6ct" ;;
                                      "qt5ct" ;;
                                      "kwalletmanager" ;;
                                      "kwallet"
                                      "qttools"
                                      "pinentry"
                                      "pinentry-tty"
                                      "docker-compose"
                                      "kiconthemes"
                                      ;;"kio"
                                      "pamixer"
                                      "breeze-gtk"
                                      "virt-manager"
                                      "qemu" ;; 
                                      "libvirt"
                                      "ovmf-x86-64" ;; Provides the needed files for UEFI boot for VMs
                                      
                                      ;; Need to add gtk portal to cover what hyprland can't
                                      ))))

(home-environment
  ;; The 'packages' field aggregates all previously defined lists of software
  ;; to be installed in our profile.
  (packages (append %dev-packages
                    %program-packages
                    %desktop-packages
                    %utility-packages
                    %lib-packages
                    %general-packages))

  ;; The 'services' field configures the background services and system settings
  ;; that will be managed by Guix Home.
  (services
   (list
    ;; Essential system services for modern desktop environments.
    (service home-dbus-service-type)
    (service home-pipewire-service-type)
    ;;    (service home-ollama-service-type)
    (service home-code-server-service-type)

    ;; Manages dotfiles in the user's home directory.
    (service home-files-service-type
             `((".guile" ,%default-dotguile)
               (".Xdefaults" ,%default-xdefaults)))

    ;; Manages configuration files located in '~/.config'.
    (service home-xdg-configuration-files-service-type
             `(("gdb/gdbinit" ,%default-gdbinit)
               ("nano/nanorc" ,%default-nanorc)))
    (service home-gpg-agent-service-type
             (home-gpg-agent-configuration (pinentry-program (file-append (specification->package
                                                                           "pinentry-tty")
                                                              "/bin/pinentry-tty"))
                                           (default-cache-ttl 28800)
                                           (max-cache-ttl 28800)
                                           (default-cache-ttl-ssh 28800)
                                           (max-cache-ttl-ssh 28800)
                                           (ssh-support? #t)
                                           (extra-content
                                            "allow-loopback-pinentry")))

    ;; Extends the sandbox for Guix commands to include an additional directory,
    ;; useful for accessing files outside the standard home paths.
    ;; In this particular case, GUIX_SANDBOX_EXTRA_SHARES is needed for Steam to recognize
    ;; external drives correctly as it is a sandboxed application.
    (simple-service 'extra-environment-variables
                    home-environment-variables-service-type
                    `(("GUIX_SANDBOX_EXTRA_SHARES" . "/games")
                      ("GUIX_GITHUB_TOKEN" . "") ;; Set this conveniently somehow
                      ("PATH" . "$HOME/.local/bin:$PATH")
                      ("NODE_PATH" . "$HOME/.local/lib/node_modules:$NODE_PATH")
                      ("npm_config_prefix" . "$HOME/.local"))))))

