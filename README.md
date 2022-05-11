# dotfiles

My environment `dotfiles`, configs & bash scripts.

## Fedora Workstation

> Last test on Fedora `35`.

Clone this repository:

```bash
git clone https://github.com/koddr/dotfiles.git && cd dotfiles
```

Make all scripts executable:

```bash
chmod +x ./fedora/*.sh
```

Run post-install script (run **only** as sudo user):

```bash
sudo ./fedora/post-install.sh
```

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

### Keyboard layout

```bash
dconf write /org/gnome/desktop/input-sources/xkb-options "['grp_led:caps', 'lv3:ralt_switch', 'misc:typo', 'nbsp:level3', 'lv3:lsgt_switch', 'grp:shift_caps_switch']"
```

### Fonts

Install needed fonts:

- [Google Fonts](https://github.com/google/fonts)
- [Liberation](https://github.com/liberationfonts/liberation-fonts)

```bash
./fedora/fonts.sh
```

### Cursors

- [Phinger cursors](https://github.com/phisch/phinger-cursors)

### Extensions

#### GNOME

- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
- [Gnome 4x UI Improvements](https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/)

#### Browser

| Name | Firefox | Chrome |
| --- | --- | --- |
| Bitwarden | [link](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/) | [link](https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb) |
| LanguageTool | [link](https://addons.mozilla.org/en-US/firefox/addon/languagetool/) | [link](https://chrome.google.com/webstore/detail/grammar-spell-checker-%E2%80%94-l/oldceeleldhonbafppcapldpdifcinji)
| uBlock Origin | [link](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/) | [link](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm)
| AdBlock Plus | [link](https://addons.mozilla.org/en-US/firefox/addon/adblock-plus/) | [link](https://chrome.google.com/webstore/detail/adblock-plus-free-ad-bloc/cfhdojbkjhnklbpkdaibdccddilifddb)
| DuckDuckGo | [link](https://addons.mozilla.org/en-US/firefox/addon/duckduckgo-for-firefox/) | [link](https://chrome.google.com/webstore/detail/duckduckgo-privacy-essent/bkdgflcldnnnapblkhphbgpggdiikppg) |

### Fish

Install [Fish](https://fishshell.com/) shell and create config folder:

```bash
sudo dnf install fish -y && mkdir -p ~/.config/fish
```

Set configuration (`~/.config/fish/config.fish`):

```bash
# Editors
set -gx EDITOR nano

# Podman
alias docker "podman"
set -gx DOCKER_HOST unix:///run/user/1000/podman/podman.sock

# Golang
set -gx PATH /usr/local/go/bin $PATH
set -gx GOPATH ~/.go
```

Set `fish` as default shell:

```bash
chsh -s /usr/bin/fish
```

> Don't forget to re-login after that 😉

### Go

Install Go (run **only** as sudo user):

```bash
sudo ./fedora/golang.sh
```

#### Go tools

- [go-critic](https://github.com/go-critic/go-critic):

```bash
go install github.com/go-critic/go-critic/cmd/gocritic@latest
```

- [golangci-lint](https://github.com/golangci/golangci-lint):

```bash
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

- [gosec](https://github.com/securego/gosec):

```bash
go install github.com/securego/gosec/v2/cmd/gosec@latest
```

- [goreleaser](https://github.com/goreleaser/goreleaser):

```bash
go install github.com/goreleaser/goreleaser@latest
```

### UPX

Install [Ultimate Packer for eXecutables](https://github.com/upx/upx):

```bash
sudo dnf install upx -y
```

### Android Studio

Just download JetBrains [Toolbox](https://www.jetbrains.com/toolbox-app/) app, copy to `~/.jetbrains/toolbox`, and install from there.

> Don't forget to Sign In to your Google account in Android Studio 😉

#### Manual installation

Install Android Studio from Google website (run **only** as sudo user):

```bash
sudo ./fedora/android-studio.sh
```

Tips & Tricks:

- Add Android Studio icon to GNOME Application list:
  - Open Android Studio by `/usr/local/android-studio/bin/studio.sh` command
  - Go to `Tools` and click `Create Desktop Entry`

### GoLand

Just download JetBrains [Toolbox](https://www.jetbrains.com/toolbox-app/) app, copy to `~/.jetbrains/toolbox`, and install from there.

> Don't forget to Sign In to your JetBrains account in GoLand 😉

### VS Code

Flathub version of the original `VS Code` is always out of date, therefore install it from the Microsoft repository. 

> `VSCodium` & `Code - OSS` are good, but they're not provided Sign In to GitHub account to sync config and keybindings (_unfortunately_).

Install VS Code from Microsoft repository (run **only** as sudo user):

```bash
sudo ./fedora/vscode.sh
```

Install needed extensions:

```bash
./fedora/vscode-extensions.sh
```

> Or just Sign In to your GitHub account in VS Code 😉

Tips & Tricks:

- Add `podman.sock` to Docker Host option in `~/.config/Code/User/settings.json`:
  - `docker.host` with `unix:///run/user/$(id -u)/podman/podman.sock` value

## NixOS

> Last test on NixOS `21.11`.

Copy `./nixos/configuration.nix` to your `/mnt/etc/nixos` folder.
