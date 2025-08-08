Contains my dotfiles including my Guix configuration files.

Other useful bits are my ZSH scripts for Github/Gitea/Codeberg syncing and SSH agent prompting.

Also includes Guix configurations for an intel Mac using my kernel patches package and t2-wifi-firmware (which isn't public).

There is an unpackaged code-server service included as I prefer to access my editor over a VPN anywhere and offload compute onto my high-end system.

Initially inspired by [Podiki](https://github.com/podiki/dot.me), but has long since been more catered to personal taste and flavor.
Styling for Hyprland is bit from [JaKooLit](https://github.com/JaKooLit/Hyprland-Dots); however, a nontrivial amount is modified to work with Guix (and my packages) in mind.

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

Once running SSH and GPG would need to be set up:
```
git config --global commit.gpgsign true
git config --global user.signingkey AE6F7F0F6E0DAFB96E848994C3A7E8D722618435
git config --global user.name "GigiaJ"
git config --global user.email "g@yahoo.com"
git config --global gpg.program $(which gpg)
git config --global push.autoSetupRemote true
```