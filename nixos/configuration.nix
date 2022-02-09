{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  #
  # Boot config:
  #

  boot.loader.grub.enable = true; # use GRUB boot loader
  boot.loader.grub.version = 2; # set GRUB version to 2
  boot.loader.grub.efiSupport = true; # enable EFI
  boot.loader.grub.device = "nodev"; # or "/dev/sda" for non-EFI install only
  boot.loader.efi.efiSysMountPoint = "/boot/efi"; # set folder to EFI
  boot.initrd.kernelModules = [ "amdgpu" ]; # load correct AMD GPU driver

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

  services.xserver = {
    layout = "us,ru";
    xkbOptions = "grp:caps_toggle,caps_led:caps";
  };

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
  # List packages installed in system profile:
  #

  environment.systemPackages = with pkgs; [
    git
    fish
    wget
    htop
    dwm
    dmenu
    alacritty
    chromium
    vscodium
    tdesktop
    mpv
  ];

  #
  # User account:
  #

  users.users.koddr = { # don't forget to set a password with 'passwd koddr' after boot
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    home = "/home/koddr";
  };

  #
  # Home manager config:
  #

  home-manager.users.koddr = { pkgs, ... }: {
    #
    # Options:
    #

    useGlobalPkgs = true;

    #
    # List of the home packages:
    #

    home.packages = [ pkgs.go ];

    #
    # Programs configs:
    #

    programs = {
      # Home manager itself:
      home-manager = {
        enable = true;
      };
      # Git:
      git = {
        enable = true;
        userName = "koddr";
        userEmail = "${GIT_EMAIL}"; # don't forget to set email here
      };
      # Fish shell:
      fizsh = {
        enable = true;
        shellAliases = {
          ll = "ls -la";
          rebuild = "sudo nixos-rebuild switch";
        };
      };
    };
  };

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