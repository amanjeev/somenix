{ lib, config, pkgs, callPackage, ... }:

let
  nixos-unstable = import (builtins.fetchGit {
    url = "https://github.com/nixos/nixpkgs-channels";
    ref = "refs/heads/nixos-unstable";
    rev = "d09d82eea34bad1faffbd1c979b17a2b073a4d2f";
  }) {};
in
{
  # system wide virtualbox is needed for headless launches
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true; # bullshit oracle pack
  users.extraGroups.vboxusers.members = [ "aj" ];

  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aj = {
    isNormalUser = true;
    home = "/home/aj";
    description = "Amanjeev Sethi";
    uid = 1000;
    useDefaultShell = true;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker" ];
  };

  users.groups.aj = {
    name = "aj";
    members = ["aj"];
    gid = 1666;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

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
  environment.systemPackages = with pkgs; [
    fish
    lm_sensors
    vagrant
    xsensors
    #nixos-unstable.zulip
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome3.enable = true;

  # This is the way to activate some Gnome 3 modules
  services.xserver.desktopManager.gnome3.sessionPath = with pkgs.gnome3; [
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
  ];
  services.xserver.xkbOptions = "ctrl:swapcaps"; # overriden by gnome (must be set using gnome tweak tool)

  programs.gpaste.enable = true;

  services.printing = {
    enable = true;
    drivers = [ pkgs.foo2zjs ];
  };

  services.gnome3 = {
    chrome-gnome-shell = {
      enable = true;
    };
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

  services.udev = {
    packages = with pkgs; [
      yubikey-personalization
      libu2f-host
    ];
  };

  services.pcscd.enable = true;
}
