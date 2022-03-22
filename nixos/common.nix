{ lib, config, pkgs, callPackage, nixos-unstable, ... }:

{
  virtualisation = {
    libvirtd.enable = true;

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

  users.groups.plugdev = {
    name = "plugdev";
    members = ["aj"];
    gid = 2666;
  };

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  i18n.defaultLocale = "en_CA.UTF-8";

  fonts.fonts = with pkgs; [
    google-fonts
    inconsolata
    iosevka
    twemoji-color-font
    powerline-fonts
    powerline-symbols
  ];

  # Set your time zone.
  time.timeZone = "America/Toronto";

  nixpkgs.config.firefox.enableGnomeExtensions = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # mostly for unfree or the undead
  environment = {
    systemPackages = with pkgs;  [
      binutils-unwrapped
      deja-dup
      fish
      gtk3
      haskellPackages.digest
      hidapi
      libguestfs  # Tools for accessing and modifying virtual machine disk images
      libvirt  # qemu kvm etc.
      libvirt-glib
      lm_sensors
      nixos-unstable._1password
      nixos-unstable._1password-gui
      nixos-unstable.jetbrains.clion
      nixos-unstable.jetbrains.goland
      nixos-unstable.jetbrains.idea-ultimate
      nixos-unstable.jetbrains.pycharm-professional
      nixos-unstable.jetbrains.ruby-mine
      nixos-unstable.jetbrains.webstorm
      nixos-unstable.zulip
      patchelf
      powerline-symbols
      sshfs
      usbutils
      vagrant
      virt-manager
      wally-cli
      webkitgtk
      xsensors
      zlib
    ];
  };

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };

    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  services = {

    gnome.chrome-gnome-shell = {
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
        gnome = {
          enable = true;
          sessionPath = with pkgs.gnome; [
            gnome-bluetooth
            gnome-calculator
            gnome-characters
            gnome-common
            gnome-control-center
            gnome-font-viewer
            gnome-keyring
            gnome-nettool
            gnome-power-manager
            gpaste
            gnome-screenshot
            gnome-settings-daemon
            gnome-shell
            gnome-shell-extensions
            gnome-tweaks
          ];
        };
      };
      
      xkbOptions = "ctrl:swapcaps"; # overriden by gnome (must be set using gnome tweak tool)
    };

    pcscd.enable = true;    
  };

  programs.gpaste.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  programs.fish = {
    enable = true;
    shellInit = import ./pkgs/confs/fish/config.nix { inherit pkgs; };
  };

}
