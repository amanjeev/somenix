{ config, pkgs, lib, ... }:

{
  networking.wireless.enable = false; # For Network Manager

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  fonts.fontconfig.enable = true;
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    jetbrains-mono
    fira-code
    fira-code-symbols
    google-fonts
    inconsolata
    iosevka
    twemoji-color-font
    powerline-fonts
    powerline-symbols
  ];

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
      enable = true;
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
 };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    chromium
    vscodeConfigured
    zotero
  ] ++ (if stdenv.isx86_64 then [
    zoom-us
    spotify
    obs-studio
    _1password-gui
  ] else [ ]);
}
