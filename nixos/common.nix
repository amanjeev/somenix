{ lib, config, pkgs, callPackage, ... }:

let
  nixos-unstable = import (builtins.fetchGit {  # last updated: 2020-06-06
    # git ls-remote https://github.com/nixos/nixpkgs-channels nixpkgs-unstable
    url = "https://github.com/nixos/nixpkgs-channels";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "dcb64ea42e64aaecd8e6fef65cc86245c9666818";
  }) { config = { allowUnfree = true; }; };
in
{
  virtualisation = {
    # system wide virtualbox is needed for headless launches
    virtualbox = {
      guest.enable = true;
      host = {
        enable = true;
        enableExtensionPack = true;  # bullshit oracle pack
      };
    };

    # system wide docker
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };
  
  users.extraGroups = {
    vboxusers.members = [ "aj" ];
    docker.members = [ "aj" ];
  };

  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aj = {
    isNormalUser = true;
    home = "/home/aj";
    description = "Amanjeev Sethi";
    uid = 1000;
    useDefaultShell = true;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker" "vboxusers" ];
  };

  users.groups.aj = {
    name = "aj";
    members = ["aj"];
    gid = 1666;
  };

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  fonts.fonts = with pkgs; [
    google-fonts
    inconsolata
    iosevka
    twemoji-color-font
  ];

  # Set your time zone.
  time.timeZone = "America/Toronto";

  nixpkgs.config.firefox.enableGnomeExtensions = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # mostly for unfree or the undead
  environment = {
    systemPackages = with pkgs;  [
      #citrix_workspace
      fish
      haskellPackages.digest
      lm_sensors
      nixos-unstable._1password
      nixos-unstable.jetbrains.clion
      nixos-unstable.jetbrains.goland
      nixos-unstable.jetbrains.idea-ultimate
      nixos-unstable.jetbrains.pycharm-professional
      nixos-unstable.jetbrains.ruby-mine
      nixos-unstable.jetbrains.webstorm
      nixos-unstable.zulip
      pkg-config
      spotify
      vagrant
      webkitgtk
      xsensors
      zlib
    ];
  };

  # Enable sound.
  sound.enable = true;
  #hardware.pulseaudio.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };

    bluetooth = {
      enable = true;
      config = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  services = {

    gnome3.chrome-gnome-shell = {
      enable = true;
    };

    lorri.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.foo2zjs pkgs.gutenprintBin pkgs.hplip ];
    };
    
    xserver = {
      displayManager = {
        gdm = {
          enable = true;
          wayland = false;
        };
        
      };
      desktopManager = {
        gnome3 = {
          enable = true;
          sessionPath = with pkgs.gnome3; [
            gnome-bluetooth
            gnome-calculator
            gnome-characters
            gnome-common
            gnome-control-center
            gnome-font-viewer
            gnome-keyring
            gnome-power-manager
            gpaste
            gnome-screenshot
            gnome-settings-daemon
            gnome-shell-extensions
            gnome-tweaks
            pomodoro
          ];
        };
      };
      
      xkbOptions = "ctrl:swapcaps"; # overriden by gnome (must be set using gnome tweak tool)
    };

    udev = {
      packages = with pkgs; [
        yubikey-personalization
        libu2f-host
      ];
    };

    pcscd.enable = true;    
  };

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = false;
  # services.xserver.desktopManager.gnome3.enable = true;

  #services.lorri.enable = true;

  # This is the way to activate some Gnome 3 modules
  # services.xserver.desktopManager.gnome3.sessionPath = with pkgs.gnome3; [
  #   gnome-bluetooth
  #   gnome-calculator
  #   gnome-characters
  #   gnome-common
  #   gnome-control-center
  #   gnome-font-viewer
  #   gnome-keyring
  #   gnome-power-manager
  #   gpaste
  #   gnome-screenshot
  #   gnome-settings-daemon
  #   gnome-shell-extensions
  #   gnome-tweaks
  #   pomodoro
  # ];
  # services.xserver.xkbOptions = "ctrl:swapcaps"; # overriden by gnome (must be set using gnome tweak tool)

  # services.printing = {
  #   enable = true;
  #   drivers = [ pkgs.foo2zjs pkgs.gutenprintBin pkgs.hplip ];
  # };

  # services.gnome3 = {
  #   chrome-gnome-shell = {
  #     enable = true;
  #   };
  # };

  #  services.udev = {
  #   packages = with pkgs; [
  #     yubikey-personalization
  #     libu2f-host
  #   ];
  # };

  # services.pcscd.enable = true;

  programs.gpaste.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  programs.fish = {
    enable = true;
    shellInit = import ./pkgs/confs/fish/config.nix { inherit pkgs; };
  };
  
  programs.zsh = {
    enable = false; 
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
    }; 
  };
}
