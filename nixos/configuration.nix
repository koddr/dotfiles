{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  #
  # Boot config:
  #

  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # https://nixos.wiki/wiki/Linux_kernel
    loader = {
      grub = {
        enable = true; # use GRUB boot loader
        version = 2; # set GRUB version to 2
        device = "nodev"; # or "/dev/sda" for non-EFI install only
        efiSupport = true; # enable EFI
      };
      efi.efiSysMountPoint = "/boot/efi"; # set folder to EFI
    };
    initrd.kernelModules = [ "amdgpu" ]; # load correct AMD GPU driver
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
    networkmanager.enable = true;
    wireless = {
      enable = true;
      networks = { # https://nixos.org/manual/nixos/stable/index.html#sec-wireless
        "${WIFI_SSID}" = { # don't forget to change this to your SSID
          hidden = true;
          pskRaw = "${WIFI_PASSWORD}"; # don't forget to run 'wpa_passphrase <SSID> <PASSWORD>' before install
        };
      };
    };
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
      displayManager = {
        gdm.enable = true; # enable gdm display manager
        defaultSession = "none+bspwm"; # add default session
      };
      windowManager.bspwm.enable = true; # enable bspwm window manager
      layout = "us,ru"; # set keyboard layout
      xkbOptions = "grp:caps_toggle,grp_led:caps,compose:ralt"; # switch keyboard layouts by Caps Lock
    };
    sxhkd = {
      enable = true; # enable easy X keybindings
      keybindings = { # https://github.com/baskerville/sxhkd
        "super + Return" = "alacritty";
      };
    };
    printing.enable = true; # enable CUPS to print documents
    openssh.enable = true; # enable the OpenSSH daemon
    blueman.enable = true; # enable GUI for bluetooth
  };
  
  #
  # XSession config:
  #

  xsession.windowManager.bspwm.enable = true;

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
    opengl = { # https://nixos.org/manual/nixos/stable/index.html#sec-gpu-accel
      driSupport = true;
      extraPackages = with pkgs; [ rocm-opencl-icd amdvlk ];
    };
    bluetooth = { # https://nixos.wiki/wiki/Bluetooth
      enable = true;
      powerOnBoot = true;
    };
  };

  #
  # Unfree config:
  #

  # nixpkgs.config.allowUnfree = true;

  #
  # Environment config:
  #

  environment = {
    # Variables:
    variables = {
      EDITOR = "micro";
      VISUAL = "codium";
      BROWSER = "chromium";
      GOPATH = "$HOME/.go";
    };

    # List packages installed in system profile:
    systemPackages = with pkgs; [
      # Window manager:
      betterlockscreen
      polybar
      ranger
      bspwm
      dunst
      sxhkd
      rofi
      feh

      # Multimedia:
      mpv

      # Terminal:
      alacritty
      fish
      htop
      wget

      # GUI Apps:
      chromium
      tdesktop
      firefox
      blueman
      
      # Development:
      vscodium
      podman
      micro
      gcc
      git
      
      # Programming languages:
      python310
      go_1_17
    ];
  };

  #
  # Programs configs:
  #

  programs = {
    # Git:
    git = {
      enable = true;
      userName = "${GIT_USERNAME}"; # don't forget to set username here
      userEmail = "${GIT_EMAIL}"; # don't forget to set email here
    };
    # Fish:
    fish = {
      enable = true;
      shellAliases = {
        ll = "ls -la";
        nic = "sudo micro /etc/nixos/configuration.nix";
        rbs = "sudo nixos-rebuild switch";
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
      (nerdfonts.override { 
        fonts = [
          "DejaVuSansMono"
          "LiberationMono"
          "JetBrainsMono"
          "FiraCode"
          "FiraMono"
          "Terminus"
          "Iosevka"
          "Noto"
          "Hack"
        ]; 
      })
      noto-fonts-emoji
      freefont_ttf
      roboto
      inter
      siji
    ];
  };

  #
  # Virtualisation config:
  #

  virtualisation = {
    podman = { # https://nixos.wiki/wiki/Podman
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
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