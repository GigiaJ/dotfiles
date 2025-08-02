So steam expects an exported share
but it also expects explicitly steamapps to be at the root of that dir

you can not pass /games/SteamLibrary
you must instead create a symlink and then place that symlink at the root




Add your user to the input group






export GUIX_SANDBOX_EXTRA_SHARES="/games" 
steam

Setting up a kdewallet is generally helpful on install. Should see if we can automate that or something.



KDE needs the splash screen disabled or it loads *REALLY* slow (30s or so)


extensionKind in VS Code (search the setting in the settings section) can be used to stop some extensions from trying to run on the local

An important note but for cloudflared and gitea...
We used git.domain.com not gitea.domain.com
Which is in line with other service providers.


(guix gexp)
Testing for building Shepherd services can be a bit of a pain
guix shell guile guile-fibers shepherd -- guile

Inside the REPL
(use-modules (shepherd service))

Then you can do something like:
(service '(sshd ssh-daemon)
         #:start (make-forkexec-constructor '("/usr/sbin/sshd" "-D") #:pid-file "/etc/ssh/sshd.pid")
         #:stop (make-kill-destructor)
         #:respawn? #t)

which will return
$1 = #<service (sshd ssh-daemon) 7f9821b55310>



So now to create the kwallet service:
guix shell guile guile-fibers shepherd -- guile

We'll need GEXP too
(use-modules (guix gexp) (shepherd service) (guix packages))

Our wallet definition is
(define (kwallet-service config)
  (list
   (shepherd-service
    (documentation "Run the KDE Wallet daemon (kwalletd6).")
    ;; Ensure the 'kwallet' package is available in the environment.
    (provision '(kwallet))
    ;; These modules provide 'make-forkexec-constructor', etc.
    (modules '((shepherd support)))
    (start #~(make-forkexec-constructor
              (list #$(file-append (specification->package "kwallet")
                                 "/bin/kwalletd6"))
              #:log-file (string-append %user-log-dir "/kwalletd6.log")))
    (stop #~(make-kill-destructor))
    (respawn? #t))))