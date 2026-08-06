;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. "~/.mycontribs/")
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(swift
     rust
     toml
     typescript
     yaml
     (clojure :variables
              clojure-backend 'lsp)
     java
     xclipboard
     javascript
     ;; ----------------------------------------------------------------
     ;; example of useful layers you may want to use right away.
     ;; uncomment some layer names and press `spc f e r' (vim style) or
     ;; `m-m f e r' (emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     better-defaults
     emacs-lisp
     git
     helm
     lsp
     markdown
     html
     multiple-cursors
     (org :variables
          org-enable-roam-support t)
     (shell :variables
            shell-default-shell 'vterm
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     version-control
     treemacs)


   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(gptel org-pomodoro pinentry clipetty org-tempo
                                            aphelei groovy-mode
                                            )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "nerd-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light). A theme from external
   ;; package can be defined with `:package', or a theme can be defined with
   ;; `:location' to download the theme package, refer the themes section in
   ;; DOCUMENTATION.org for the full theme specifications.
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. This setting has no effect when
   ;; running Emacs in terminal. The font set here will be used for default and
   ;; fixed-pitch faces. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '("Source Code Pro"
                               :size 10.0
                               :weight normal
                               :width normal)

   ;; Default icons font, it can be `all-the-icons' or `nerd-icons'.
   dotspacemacs-default-icons-font 'all-the-icons

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "M-<return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "M-<return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; It is also possible to use a posframe with the following cons cell
   ;; `(posframe . position)' where position can be one of `center',
   ;; `top-center', `bottom-center', `top-left-corner', `top-right-corner',
   ;; `top-right-corner', `bottom-left-corner' or `bottom-right-corner'
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; Make consecutive tab key presses after commands such as
   ;; `spacemacs/alternate-buffer' (SPC TAB) cycle through previous
   ;; buffers/windows/etc. Please see the option's docstring for more information.
   ;; Set the option to t in order to enable cycling for all current and
   ;; future cycling commands. Alternatively, choose a subset of the currently
   ;; supported commands: '(alternate-buffer alternate-window). (default nil)
   dotspacemacs-enable-cycling nil

   ;; Whether side windows (such as those created by treemacs or neotree)
   ;; are kept or minimized by `spacemacs/toggle-maximize-window' (SPC w m).
   ;; (default t)
   dotspacemacs-maximize-window-keep-side-windows t

   ;; If nil, no load-hints enabled. If t, enable the `load-hints' which will
   ;; put the most likely path on the top of `load-path' to reduce walking
   ;; through the whole `load-path'. It's an experimental feature to speedup
   ;; Spacemacs on Windows. Refer the FAQ.org "load-hints" session for details.
   dotspacemacs-enable-load-hints nil

   ;; If t, enable the `package-quickstart' feature to avoid full package
   ;; loading, otherwise no `package-quickstart' attemption (default nil).
   ;; Refer the FAQ.org "package-quickstart" section for details.
   dotspacemacs-enable-package-quickstart nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default t) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' to obtain fullscreen
   ;; without external boxes. Also disables the internal border. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes the
   ;; transparency level of a frame background when it's active or selected. Transparency
   ;; can be toggled through `toggle-background-transparency'. (default 90)
   dotspacemacs-background-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `ack' and `grep'.
   ;; (default '("rg" "ag" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "ack" "grep")

   ;; The backend used for undo/redo functionality. Possible values are
   ;; `undo-redo', `undo-fu' and `undo-tree' see also `evil-undo-system'.
   ;; Note that saved undo history does not get transferred when changing
   ;; your undo system from or to undo-tree. (default `undo-redo')
   dotspacemacs-undo-system 'undo-redo

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Color highlight trailing whitespace in all prog-mode and text-mode derived
   ;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
   ;; (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; The variable `global-spacemacs-whitespace-cleanup-modes' controls
   ;; which major modes have whitespace cleanup enabled or disabled
   ;; by default.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."

  (setq network-lookup-address-internal-default-family 'ipv4)
  (setq url-gateway-unplugged nil)


  (advice-add 'version-to-list :around
              (lambda (orig-fun version)
                (condition-case nil
                    (funcall orig-fun version)
                  (error '(0 5 0)))))

  (setq select-enable-clipboard t)
  (setq select-enable-primary t)
  (setq save-interprogram-paste-before-kill t)

  (setq treemacs-use-projectile-concept t)
  (treemacs-project-follow-mode 1)

  )


(defun my/open-treemacs-on-startup (frame)
  (with-selected-frame frame
    (unless (treemacs-current-visibility)
      (treemacs))))


(defun my/init-eaf ()
  "Load EAF and ensure extensions are wired correctly."
  (require 'eaf)
  (require 'eaf-browser)
  )



(defun my/refresh-agenda-files ()
  "Refresh agenda files for the month and add the habit file."
  (interactive)
  (let* ((month-str (format-time-string "%Y-%m"))
         (habit-file (expand-file-name "~/Journal/habits.org"))
         (all-files (directory-files-recursively (expand-file-name "~/Journal") "\\.org$"))
         (clean-list (seq-filter
                      (lambda (path)
                        (let ((filename (file-name-nondirectory path)))
                          (and (string-match-p month-str filename)
                               (not (string-prefix-p "." filename))
                               (not (string-prefix-p "#" filename)))))
                      all-files)))
    (setq org-agenda-files (append clean-list (list habit-file)))))



(defun my/org-tangle-mirror-to-src ()
  "Mirror docs/ to src/ but return a relative path for the :tangle header."
  (let* ((project-root (project-root (project-current t)))
         (docs-root (expand-file-name "docs/" project-root))
         (current-file (buffer-file-name))
         (rel-from-docs (file-relative-name current-file docs-root))
         (target-abs-path (expand-file-name
                           (concat "src/" (file-name-sans-extension rel-from-docs) ".cljs")
                           project-root)))
    (make-directory (file-name-directory target-abs-path) t)
    (file-relative-name target-abs-path (file-name-directory current-file))))



(defun my/org-yas-expand ()
  "Try to expand a snippet, then fallback to normal org-cycle."
  (interactive)
  (or (yas-expand)
      (org-cycle)))



(defun my/polymode-flycheck-setup ()
  "Ensure Flycheck selects the correct checker for the current chunk."
  (when (bound-and-true-p flycheck-mode)
    (flycheck-set-checker-executable-variable nil)
    (flycheck-select-checker)))

(defun my/polymode-spell-logic ()
  "Switch between full spell-check and code-only spell-check."
  (if (derived-mode-p 'prog-mode)
      (progn
        (flyspell-mode -1)
        (flyspell-prog-mode 1))
    (progn
      (flyspell-prog-mode -1)
      (flyspell-mode 1))))



(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'my/init-eaf)
    (my/init-eaf))
  (add-hook 'projectile-after-switch-project-hook #'treemacs-display-current-project-exclusively)


  (add-hook 'polymode-after-switch-buffer-hook #'my/polymode-flycheck-setup)
  (add-hook 'polymode-after-switch-buffer-hook #'my/polymode-spell-logic)

  (spacemacs|define-transient-state quick-nav
    :title "Quick Navigation & Org Cheat Sheet"
    :doc "\n
[_t_] Active TODOs  [_m_] Match Tag/Keyword  [_j_] Journal Entry
[_s_] Magit Status  [_p_] Magit Push         [_b_] Switch Buffer
[_c_] Pomodoro
[_q_] quit"
    :bindings
    ("t" org-todo-list)
    ("m" org-tags-view)
    ("j" org-roam-dailies-goto-today)
    ("c" org-pomodoro)
    ("s" magit-status)
    ("p" magit-push)
    ("b" helm-mini)
    ("q" nil :exit t))

  (spacemacs/set-leader-keys "oc" 'spacemacs/quick-nav-transient-state/body)


  (setenv "GPG_TTY" "")
  (setenv "INSIDE_EMACS" (format "%s,magit" emacs-version))
  (setq epa-pinentry-mode 'loopback)
  (setq epg-pinentry-mode 'loopback)
  (pinentry-start)



  (load "~/.emacs.d/.gptel-keys.el" t)

  (use-package gptel
    :ensure t
    :config
    (setq gptel-backend
          (gptel-make-gemini
              "Gemini"
            :key gptel-gemini-api-key)))

  (setq gptel-model 'gemini-2.5-flash)

  (setq multi-term-program "/home/jaggar/.guix-home/profile/bin/zsh")
  (setq vterm-shell "/home/jaggar/.guix-home/profile/bin/zsh")

  (if (daemonp)
      (add-hook 'after-make-frame-functions #'my/open-treemacs-on-startup)
    (treemacs))

  (setq gptel-display-buffer-action
        '((display-buffer-in-direction)
          (direction . right)
          (window-width . 0.35)))

  (with-eval-after-load 'org
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((shell . t)
       (clojure . t)
       (js . t)))

    (setq org-hide-emphasis-markers t)
    (add-to-list 'org-modules 'org-habit)
    (add-to-list 'display-buffer-alist
                 '("\\*org-roam\\*"
                   (display-buffer-in-side-window)
                   (side . left)
                   (window-width . 0.25))))

  (with-eval-after-load 'org-roam
    (setq org-roam-directory (file-truename "~/Journal"))
    (setq org-roam-dailies-directory ".")

    (global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
    (global-set-key (kbd "C-c n f") 'org-roam-node-find)
    (global-set-key (kbd "C-c n i") 'org-roam-node-insert)
    (global-set-key (kbd "C-c n c") 'org-roam-capture)
    (global-set-key (kbd "C-c n d") 'org-roam-dailies-capture-today)

    (org-roam-db-autosync-mode))

  (with-eval-after-load 'org-pomodoro
    (setq org-pomodoro-length 25
          org-pomodoro-short-break-length 5))


  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

  (setq web-mode-content-types-alist
        '(("jsx" . "\\.tsx\\'")))


  (add-hook 'org-agenda-mode-hook #'my/refresh-agenda-files)

  (with-eval-after-load 'org-roam
    (setq org-roam-dailies-capture-templates
          '(("d" "dev" plain "* Problem\n\n%?* Solution\n\n* Notes\n"
             :target (file+head "dev/journal/daily/%<%Y-%m-%d>.org"
                                "#+title: %<%Y.%m.%d>\n#+filetags: dev\n")
             :unnarrowed t)
            ("w" "work" plain "* Tasks\n\n%?* Meetings\n\n* Log\n"
             :target (file+head "work/journal/daily/%<%Y-%m-%d>.org"
                                "#+title: %<%Y.%m.%d>\n#+filetags: work\n")
             :unnarrowed t)
            ("p" "personal" plain "* Journal\n%?"
             :target (file+head "personal/journal/daily/%<%Y-%m-%d>.org"
                                "#+title: %<%Y.%m.%d>\n#+filetags: personal\n")
             :unnarrowed t))))

  (setq org-clock-out-when-done t
        org-clock-persist t
        org-drawers '("PROPERTIES" "LOGBOOK")
        org-clock-into-drawer "LOGBOOK")
  (org-clock-persistence-insinuate)

  (setq org-pomodoro-play-sounds t
        org-pomodoro-show-notifications t)

  (use-package yasnippet
    :ensure t
    :config
    (yas-global-mode 1))

  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist
               '("cljs" . "src clojurescript"))


  (with-eval-after-load 'org
    (define-key org-mode-map (kbd "<tab>") #'my/org-yas-expand)
    (define-key org-mode-map (kbd "TAB") #'my/org-yas-expand))



  (with-eval-after-load 'evil


    (define-key evil-normal-state-map (kbd "p") 'kitty-paste))
  (setq org-babel-clojure-backend 'cider)

  (add-hook 'org-src-mode-hook #'smartparens-mode)
  (add-hook 'org-src-mode-hook #'sp-show-pair-mode)
  (add-hook 'org-src-mode-hook #'show-paren-mode)
                                        ;(setq org-src-fontify-natively t)
                                        ;  (setq org-src-tab-acts-natively t)

  (require 'poly-org)
  (add-to-list 'auto-mode-alist '("\\.org\\'" . poly-org-mode))
  (require 'clipetty)
  (global-clipetty-mode)

  (use-package apheleia
    :ensure t
    :init
    (apheleia-global-mode +1)
    :config
    (setf (alist-get 'cljfmt apheleia-formatters)
          '("cljfmt" "fix" "--edn" "{:indent-style :align-arguments :max-line-length 100 :remove-consecutive-blank-lines? true}" "-")))


  (add-to-list 'apheleia-mode-alist '(clojure-mode . cljfmt))
  (add-to-list 'apheleia-mode-alist '(clojurescript-mode . cljfmt))


  (setq flyspell-issue-message-flag nil)
  (setq-default flyspell-delay 1)
  (setq polymode-move-too-distant-limit 100000)
  (setq polymode-process-buffer-manually t)
  (add-hook 'polymode-after-switch-buffer-hook #'font-lock-fontify-buffer)
  (setq flycheck-checker-error-threshold nil)



  )







;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(org-agenda-files
     '("/home/jaggar/Journal/dev/journal/daily/2026-02-11.org"
       "/home/jaggar/Journal/dev/journal/daily/2026-02-12.org"
       "/home/jaggar/Journal/personal/journal/daily/2026-02-11.org"
       "/home/jaggar/Journal/personal/journal/daily/2026-02-12.org"
       "/home/jaggar/Journal/work/journal/daily/2026-02-11.org"))
   '(package-selected-packages
     '(2048-game ace-link add-node-modules-path adoc-mode afternoon-theme
                 aggressive-indent alchemist alect-themes all-the-icons
                 ample-theme amx ansible ansible-doc apache-mode apheleia
                 arduino-mode auctex auto-compile auto-complete
                 auto-highlight-symbol auto-yasnippet avy-jump-helm-line biblio
                 blacken browse-at-remote cc-mode centaur-tabs
                 centered-cursor-mode chocolate-theme cider-eval-sexp-fu
                 claude-code-ide clean-aindent-mode clipetty clj-refactor
                 clojure-snippets code-review color-theme-sanityinc-tomorrow
                 column-enforce-mode company-cabal company-coq company-emoji
                 company-lua company-quickhelp company-restclient company-web
                 consult-denote counsel-notmuch counsel-projectile csv-mode
                 cyberpunk-theme dart-mode define-word deft denote-menu
                 desktop-environment devdocs dhall-mode diff-hl diminish
                 dired-quick-sort disable-mouse djvu djvu3 docker docker-tramp
                 doom-modeline doom-themes dotenv-mode dracula-theme drag-stuff
                 dtrt-indent dumb-jump eaf-browser eat ebuild-mode edit-indirect
                 edit-server ef-themes eglot ein elfeed-goodies elisp-def
                 elisp-demos elisp-slime-nav ellama elm-mode ement emmet-mode emr
                 engine-mode epc erc erc-image erlang ert-async es-mode esh-help
                 eshell-prompt-extras eshell-z evil-anzu evil-args
                 evil-cleverparens evil-collection evil-commentary evil-easymotion
                 evil-escape evil-evilified-state evil-exchange evil-goggles
                 evil-iedit-state evil-indent-plus evil-lion evil-lisp-state
                 evil-matchit evil-mc evil-nerd-commenter evil-numbers evil-org
                 evil-surround evil-textobj-line evil-tutor evil-unimpaired
                 evil-visual-mark-mode evil-visualstar exotica-theme expand-region
                 extempore-mode eyebrowse fancy-battery feature-mode
                 flycheck-clj-kondo flycheck-clojure flycheck-elm flycheck-elsa
                 flycheck-joker flycheck-ledger flycheck-package flycheck-pos-tip
                 flyspell-correct-helm fountain-mode geiser-chez ggtags gh-md
                 git-gutter git-link git-messenger git-modes git-timemachine
                 gitignore-templates gnuplot go-mode golden-ratio google-translate
                 gptel graphql-mode graphviz-dot-mode grizzl groovy-imports gt
                 hackernews haml-mode helm-ag helm-bibtex helm-c-yasnippet
                 helm-cider helm-comint helm-company helm-css-scss helm-descbinds
                 helm-ls-git helm-lsp helm-make helm-mode-manager helm-org
                 helm-org-rifle helm-projectile helm-purpose helm-swoop helm-xref
                 helpful hide-comnt highlight-indentation highlight-numbers
                 highlight-parentheses hl-todo holy-mode htmlize hungry-delete
                 hy-mode hybrid-mode ibuffer-projectile impatient-mode import-js
                 indent-guide info+ inspector irfc ivy-pass jabber jq-mode js-doc
                 js2-refactor json-mode json-reformat jsonnet-mode julia-mode
                 julia-repl kaocha-runner langtool ligature livid-mode loop
                 lorem-ipsum lsp-java lsp-metals lsp-origami lsp-sourcekit lsp-ui
                 macrostep marginalia markdown-toc markup-faces maven-test-mode
                 memoize meson-mode metal-mercury-mode migemo moe-theme
                 monokai-theme multi-line multi-term multi-vterm mvn mwim nameless
                 names nasm-mode neotree nginx-mode nodejs-repl npm-mode nyan-mode
                 oauth2 olivetti open-junk-file org-cliplink org-contrib
                 org-download org-mime org-pomodoro org-present org-projectile
                 org-rich-yank org-roam org-superstar orgit-forge outshine
                 overseer ox-pandoc packed page-break-lines pandoc-mode paradox
                 parinfer-rust-mode parsebib password-generator pcache pcre2el
                 pinentry plantuml-mode poly-org prettier-js prodigy protobuf-mode
                 psc-ide pug-mode puppet-mode purescript-mode pyim pyvenv quickrun
                 racket-mode railscasts-theme rainbow-blocks rainbow-delimiters
                 realgud rebecca-theme repo restart-emacs rjsx-mode ron-mode
                 rustic sass-mode sayid sbt-mode scss-mode sesman shell-pop
                 skewer-mode slack slim-mode smeargle sml-mode soothe-theme
                 space-doc spacegray-theme spaceline spacemacs-purpose-popwin
                 spacemacs-whitespace-cleanup spray sql-indent
                 string-edit-at-point string-inflection swift-mode symbol-overlay
                 symon tagedit tao-theme term-cursor terminal-here tern tide
                 toc-org toml-mode tramp transmission treemacs-evil
                 treemacs-icons-dired treemacs-magit treemacs-persp
                 treemacs-projectile twittering-mode typescript-mode typo
                 undercover undo-fu-session undo-tree unfill use-package valign
                 vi-tilde-fringe vimrc-mode volatile-highlights vundo
                 wakatime-mode web-beautify web-completion-data web-mode
                 web-server wgrep which-key winum writeroom-mode ws-butler
                 yaml-mode yasnippet-snippets zenburn-theme zig-mode zprint-mode)))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  )
