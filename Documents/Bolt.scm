(define-public bolt-launcher
  (package
    (inherit (gnu packages base))
    (name "bolt-launcher")
    (version "0.10.0-1")
    (source (git-url "https://aur.archlinux.org/bolt-launcher.git"))
    (build-system gnu-build-system)
    (arguments '(package-version)
      (specifications
        (substitute-key "source" (string-append "https://aur.archlinux.org/bolt-launcher-" package-version ".tar.gz"))
        (substitute-key "sha256" "your-sha256-checksum-here")))
    (synopsis "Free open-source third-party implementation of the Jagex Launcher")
    (description "Free open-source third-party implementation of the Jagex Launcher")
    (home-page "https://github.com/Adamcake/Bolt")
    (license "GPL-3.0-or-later")
    (maintainer "Your Name <your-email@example.com>")
    (build-inputs '("dependency1" "dependency2"))
    (build-patches '("patch1.patch" "patch2.patch"))
    (phases %standard-phases
      (begin
        (substitute-key "source" (string-append "https://aur.archlinux.org/bolt-launcher-" package-version ".tar.gz"))
        (substitute-key "sha256" "your-sha256-checksum-here")
        (make-directory "build")
        (copy "source" "build")
        (cd "build"
          (system* "makepkg" "--nocheck" "--syncdeps" "--needed" "--install"))
        (delete-file "build")))))
