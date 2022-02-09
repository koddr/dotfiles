{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  #
  # Boot config:
  #

  boot = {
    loader = {
      grub = {
        enable = true; # use GRUB boot loader
        version = 2; # set GRUB version to 2
        device = "nodev"; # or "/dev/sda" for non-EFI install only
        efiSupport = true; # enable EFI
      };
      efi = {
        efiSysMountPoint = "/boot/efi"; # set folder to EFI
      };
    };
    initrd = {
      kernelModules = [ "amdgpu" ]; # load correct AMD GPU driver
    };
  };

  #
  # Time zone config:
  #

  time.timeZone = "Europe/Moscow";

  #
  # Networking config:
  #

  networking = {
    hostName = "nixos-local";
    wireless.enable = true;
    useDHCP = false;
    interfaces.enp1s0.useDHCP = true;
  };

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

  services = {
    xserver = {
      enable = true; # enable the X11 windowing system
      videoDrivers = [ "amdgpu" ]; # use correct AMD GPU drivers for X11
      displayManager.lightdm.enable = true; # enable lightdm display manager
      windowManager.dwm.enable = true; # enable dwm window manager
      layout = "us,ru"; # set keyboard layout
      xkbOptions = "grp:caps_toggle,grp_led:caps"; # switch keyboard layouts by Caps Lock
    };
    printing.enable = true; # enable CUPS to print documents
    openssh.enable = true; # enable the OpenSSH daemon
    blueman.enable = true; # GUI for bluetooth
  };

  #
  # Hardware config:
  #

  sound.enable = true; # enable sound

  hardware = {
    pulseaudio = { # https://nixos.wiki/wiki/ALSA
      enable = true;
      support32Bit = true;
      extraModules = with pkgs; [ pulseaudio-modules-bt ];
      package = pkgs.pulseaudioFull;
    };
    opengl = {
      driSupport = true; # enable Vulkan driver
      extraPackages = with pkgs; [ rocm-opencl-icd amdvlk ]; # use OpenCL or Vulcan drivers (auto)
    };
    bluetooth = { # https://nixos.wiki/wiki/Bluetooth
      enable = true;
      powerOnBoot = true;
    };
  };

  #
  # Environment variables:
  #

  environment.variables = {
    EDITOR = "codium";
    VISUAL = "codium";
    BROWSER = "chromium";
    GOPATH = "$HOME/.go";
  };

  #
  # List packages installed in system profile:
  #

  environment.systemPackages = with pkgs; [
    git
    fish
    wget
    htop
    dwm
    dmenu
    blueman
    alacritty
    chromium
    vscodium
    tdesktop
    mpv
    go_1_17
  ];

  #
  # Programs configs:
  #

  programs = {
    # Git:
    git = {
      enable = true;
      userName = "koddr";
      userEmail = "${GIT_EMAIL}"; # don't forget to set email here
    };
    # Fish shell:
    fish = {
      enable = true;
      shellAliases = {
        ll = "ls -la";
        rebuild = "sudo nixos-rebuild switch";
      };
    };
  };

  #
  # List fonts installed in system:
  #

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      noto-fonts-emoji
      powerline-fonts
      liberation_ttf
      terminus_font
      freefont_ttf
      dejavu_fonts
      gyre-fonts
      corefonts
      nerdfonts
      unifont
    ];
  };

  #
  # User account:
  #

  users.users.koddr = { # don't forget to set a password with 'passwd koddr' after boot
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    home = "/home/koddr";
    shell = pkgs.fish;
  };

  #
  # NixOS version.
  #

  system.stateVersion = "21.11";
}