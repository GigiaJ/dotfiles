Contains my dotfiles including my Guix configuration files.

Can be applied to the current user home directory with stow.
Like:
```
stow floorp guix hypr wireplumber zsh code-server
```
would apply those specific stow directories to the current user home directory to something of the following form:
```
~/dotfiles/
├── code-server/
│   └── .local/share/code-server/
├── floorp/
│   └── .floorp/
├── guix/
│   └── .config/guix/
├── hypr/
│   └── .config/hypr/
├── wireplumber/
│   └── .config/wireplumber/
└── zsh/
    └── .config/zsh/
```
where for example zsh ends up at ~/.config/zsh


To provide an easily reproducible environment.

Some bits need to be cleaned up and code-server extensions might need to be a bit... cleaner. Not sure if it auto-installs if they're missing.