{ lib, config, pkgs, callPackage, ... }:


let
  unstable = import <nixos-unstable> {};
in
{
  # system wide virtualbox is needed for headless launches
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true; # bullshit oracle pack
  users.extraGroups.vboxusers.members = [ "aj" ];

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
    unstable.zulip
    vagrant
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
    gpaste
    gnome-power-manager
    gnome-tweaks
    gnome-shell-extensions
    gnome-font-viewer
    gnome-keyring
    gnome-bluetooth
    gnome-control-center
    gnome-calculator
    gnome-common
  ];
  services.xserver.xkbOptions = "ctrl:swapcaps"; # overriden by gnome (must be set using gnome tweak tool)

  services.printing = {
    enable = true;
    drivers = [ pkgs.foo2zjs ];
  };

  services.gnome3.chrome-gnome-shell.enable = true;

  users.defaultUserShell = pkgs.fish;
  
  programs.fish = {
    enable = true;
    shellAliases = {
      l = "ls -lsah";
    };
    shellInit = "starship init fish | source";
  };
  
  programs.zsh = {
    enable = false; 
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
    }; 
  };
}
