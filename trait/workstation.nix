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
    lorri.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.foo2zjs pkgs.gutenprintBin pkgs.hplip ];
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
