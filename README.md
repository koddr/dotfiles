# dotfiles

My environment `dotfiles`, configs & bash scripts.

## Fedora Workstation

> Last test on Fedora `36`.

### Speed up DNF

Open config:

```bash
sudo nano /etc/dnf/dnf.conf
```

Add this lines:

```bash
fastestmirror=True
skip_if_unavailable=True
max_parallel_downloads=10
```

Clean cache:

```bash
sudo dnf clean all
```

### Post-intall script

Clone this repository:

```bash
git clone https://github.com/koddr/dotfiles.git && cd dotfiles
```

Run post-install script (run **only** as sudo user):

```bash
sudo make fedora-post-install
```

### Fonts

- [Google Fonts](https://github.com/google/fonts)
- [Liberation](https://github.com/liberationfonts/liberation-fonts)

### Cursors

- [Phinger cursors](https://github.com/phisch/phinger-cursors)

### AMD hardware hacks

Open default grub [config](https://wiki.archlinux.org/title/Kernel_parameters#GRUB):

```bash
sudo nano /etc/default/grub
```

Add this line:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="amdgpu.noretry=0"
```

Re-build grub config:

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

> Don't forget to restart after that and check kernel params by `cat /proc/cmdline` command 😉

### GNOME

| Name         | -                                                                |
| ------------ | ---------------------------------------------------------------- |
| Dash to Dock | [link](https://extensions.gnome.org/extension/307/dash-to-dock/) |

### Browser

| Name          | Firefox                                                                            | Chrome                                                                                                               |
| ------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Bitwarden     | [link](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/) | [link](https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb)         |
| LanguageTool  | [link](https://addons.mozilla.org/en-US/firefox/addon/languagetool/)               | [link](https://chrome.google.com/webstore/detail/grammar-spell-checker-%E2%80%94-l/oldceeleldhonbafppcapldpdifcinji) |
| uBlock Origin | [link](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)              | [link](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm)                     |
| AdBlock Plus  | [link](https://addons.mozilla.org/en-US/firefox/addon/adblock-plus/)               | [link](https://chrome.google.com/webstore/detail/adblock-plus-free-ad-bloc/cfhdojbkjhnklbpkdaibdccddilifddb)         |
| DuckDuckGo    | [link](https://addons.mozilla.org/en-US/firefox/addon/duckduckgo-for-firefox/)     | [link](https://chrome.google.com/webstore/detail/duckduckgo-privacy-essent/bkdgflcldnnnapblkhphbgpggdiikppg)         |

### Shell

#### Fish

Add [Fish](https://fishshell.com/) shell config:

```bash
make fish-shell-config
```

### Go

Install Go (run **only** as sudo user):

```bash
sudo make golang-install VERSION=1.18.3
```

> To update/re-install Go, just run this command with needed version 😉

#### Go tools

Install special Go tools for projects:

```bash
make golang-tools
```

- [go-critic](https://github.com/go-critic/go-critic)
- [golangci-lint](https://github.com/golangci/golangci-lint)
- [gosec](https://github.com/securego/gosec)
- [goreleaser](https://github.com/goreleaser/goreleaser)

### IDE

#### JetBrains

Just [download](https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux) JetBrains Toolbox app, copy to `~/.jetbrains/toolbox`, and install any IDEs from there.

> Don't forget to Sign In to your Google Account in IDE 😉

#### VSCode

Install VSCode from Microsoft repository (run **only** as sudo user):

```bash
sudo make vscode-install
```

> Don't forget to Sign In to your GitHub account in VSCode 😉

## NixOS

> Last test on NixOS `21.11`.

Copy `./configs/nixos/configuration.nix` to your `/mnt/etc/nixos` folder.
