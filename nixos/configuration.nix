{ config, pkgs, ... }:
 
{
	imports = [
		./hardware-configuration.nix
	];

	#
	# Boot config:
	#
 
	# Use the GRUB 2 boot loader.
	boot.loader.grub.enable = true;
	boot.loader.grub.version = 2;
	# boot.loader.grub.efiSupport = true;
	# boot.loader.grub.efiInstallAsRemovable = true;
	# boot.loader.efi.efiSysMountPoint = "/boot/efi";

	# Define on which hard drive you want to install Grub.
	boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only

	# Load correct AMD GPU driver.
	boot.initrd.kernelModules = [ "amdgpu" ];

	#
	# Time zone config:
	#

	time.timeZone = "Europe/Moscow";
	
	#
	# Networking config:
	#

	networking.hostName = "nixos-local";
	networking.wireless.enable = true;
 
	# The global useDHCP flag is deprecated, therefore explicitly set to false here.
	# Per-interface useDHCP will be mandatory in the future, so this generated config
	# replicates the default behaviour.
	networking.useDHCP = false;
	networking.interfaces.enp1s0.useDHCP = true;
	
	#
	# Internationalisation config:
	#

	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

	#
	# List services that you want to enable:
	#

	services.xserver.enable = true; # enable the X11 windowing system
	services.xserver.displayManager.lightdm.enable = true; # enable lightdm display manager
	services.xserver.windowManager.dwm.enable = true; # enable dwm window manager
	services.printing.enable = true; # enable CUPS to print documents
	services.openssh.enable = true; # enable the OpenSSH daemon
	
	#
	# Keymap config (in X11):
	#

	services.xserver.layout = "us,ru";
	services.xserver.xkbOptions = "eurosign:e";
	
	#
	# Hardware config:
	#
	
	sound.enable = true; # enable sound
	hardware.pulseaudio.enable = true; # enable pulseaudio driver for sound

	services.xserver.videoDrivers = [ "amdgpu" ]; # use correct AMD GPU drivers for X11
	hardware.opengl.driSupport = true; # enable Vulkan driver
	hardware.opengl.extraPackages = with pkgs; [ # use OpenCL or Vulcan drivers (auto)
		rocm-opencl-icd
		amdvlk
	];

	#
	# User account:
	#

	users.extraUsers = {
		koddr = { # don't forget to set a password with 'passwd' after boot
			isNormalUser = true;
			extraGroups = [
				"wheel"
				"networkmanager"
			];
			shell = "/run/current-system/sw/bin/zsh";  
		};
	};
	
	#
	# List packages installed in system profile:
	#
	
	environment.systemPackages = with pkgs; [
		zsh wget git
		dwm dmenu st
		alacritty
		chromium
		vscodium
		mpv
	];

	#
	# List fonts installed in system:
	#
 
	fonts.fonts = [
		pkgs.noto-fonts-emoji
		pkgs.liberation_ttf
		pkgs.terminus_font
		pkgs.freefont_ttf
		pkgs.dejavu_fonts
		pkgs.gyre-fonts
		pkgs.unifont
	];

	#
	# NixOS version.
	#

	system.stateVersion = "21.11";
}