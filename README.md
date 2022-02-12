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

### Extensions

#### GNOME

- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
- [Gnome 4x UI Improvements](https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/)

#### Firefox

- [Bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/)
- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
- [DuckDuckGo](https://addons.mozilla.org/en-US/firefox/addon/duckduckgo-for-firefox/)
- [HTTPS Everywhere](https://www.eff.org/https-everywhere)

### Fonts

Install needed fonts:

- [Google Fonts](https://github.com/google/fonts)
- [Liberation](https://github.com/liberationfonts/liberation-fonts)

```bash
./fedora/fonts.sh
```

### Android Studio

Install Android Studio from Google website (run **only** as sudo user):

```bash
sudo ./fedora/android-studio.sh
```

Tips & Tricks:

- Add Android Studio icon to GNOME Application list:
  - Open Android Studio by `/usr/local/android-studio/bin/studio.sh` command
  - Go to `Tools` and click `Create Desktop Entry`

### VS Code

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