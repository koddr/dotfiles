.PHONY: fedora-post-install golang-install golang-tools fish-shell-config vscode-install

#############
# VARIABLES #
#############

USER_NAME="koddr"
RPM_FUSION_URL="https://mirrors.rpmfusion.org/free/fedora/rpmfusion"
GITHUB_CONFIG_URL="https://raw.githubusercontent.com/koddr/dotfiles/master/configs"
MICROSOFT_PACKAGES_URL="https://packages.microsoft.com"

#############
# MAIN TASK #
#############

all:
	@echo ""
	@echo "🔴 Uh-oh. It looks like you didn't specify the right command! Look for all available ones in the Makefile."
	@echo ""

####################
# INDIVIDUAL TASKS #
####################

fedora-post-install:
	@echo "🟢 Set $(USER_NAME) to sudo users group"

	usermod -aG wheel $(USER_NAME)

	@echo "🟢 Enable Podman socket"

	systemctl --user enable --now podman.socket

	@echo "🟢 Set default keyboard layout (EN: caps, RU: shift + caps, symbols: right alt + <...>)"

	dconf write \
		/org/gnome/desktop/input-sources/xkb-options \
		"['grp_led:caps', 'lv3:ralt_switch', 'misc:typo', 'nbsp:level3', 'lv3:lsgt_switch', 'grp:shift_caps_switch']"

	@echo "🟡 Remove unused DNF packages"

	dnf remove -y \
		cheese rhythmbox orca samba-client nautilus-sendto simple-scan virtualbox-guest-additions gedit mediawriter yelp \
		gnome-boxesd gnome-boxes gnome-contacts gnome-getting-started-docs gnome-maps gnome-photos gnome-tour gnome-connections
	
	@echo "🟢 Update and upgrade Fedora $(rpm -E %fedora) packages"

	dnf check-update -y
	dnf upgrade -y
	
	@echo "🟢 Install RPM Fusion (free & non-free)"

	dnf install -y \
		$(RPM_FUSION_URL)-free-release-$(rpm -E %fedora).noarch.rpm \
		$(RPM_FUSION_URL)-nonfree-release-$(rpm -E %fedora).noarch.rpm

	@echo "🟢 Install system utils & packages from DNF"

	dnf install -y \
		fish qemu virt-manager upx xclip openssl

	@echo "🟢 Install Microsoft fonts from DNF"

	dnf install -y \
		https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

	@echo "🟢 Add FlatHub repositories"

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	@echo "🟢 Install system utils & packages from Flatpak"

	flatpak install flathub \
		com.mattjakeman.ExtensionManager org.telegram.desktop org.gnome.TextEditor

	@echo "🟡 Clean up (auto remove) DNF packages"

	dnf autoremove -y

	@echo "🟡 Clean up fonts cache"

	fc-cache -f

golang-install:
	@echo "🟡 Remove old Go version from system"

	rm -rf /usr/local/go

	@echo "🟢 Download & install Go v$(VERSION)"

	wget "https://go.dev/dl/go$(VERSION).linux-amd64.tar.gz" -O /tmp/go.tar.gz
	tar -C /usr/local -xzf /tmp/go.tar.gz

	@echo "🟡 Remove temp files"

	rm /tmp/go.tar.gz

golang-tools:
	@echo "🟢 Install Go tools"

	go install github.com/go-critic/go-critic/cmd/gocritic@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install github.com/securego/gosec/v2/cmd/gosec@latest
	go install github.com/goreleaser/goreleaser@latest

fish-shell-config:
	@echo "🟢 Download Fish shell config from GitHub to ~/.config"

	wget "$(GITHUB_CONFIG_URL)/fish/config.fish" -O /home/$(USER_NAME)/.config/fish/config.fish

	@echo "🟢 Set Fish config owner to $(USER_NAME)"

	chown $(USER_NAME):$(USER_NAME) /home/$(USER_NAME)/.config/fish/config.fish
	
	@echo "🟢 Set default system shell to Fish"

	chsh -s /usr/bin/fish

vscode-install:
	@echo "🟢 Add Microsoft packages repository"

	rpm --import $(MICROSOFT_PACKAGES_URL)/keys/microsoft.asc

	@echo "🟢 Download config for official VSCode repository"

	wget "$(GITHUB_CONFIG_URL)/microsoft/vscode.repo" -O /etc/yum.repos.d/vscode.repo

	@echo "🟢 Update and upgrade Fedora $(rpm -E %fedora) packages"

	dnf check-update -y
	dnf upgrade -y

	@echo "🟢 Install VSCode"

	dnf install -y code