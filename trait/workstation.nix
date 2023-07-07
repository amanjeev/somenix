{ config, pkgs, pkgs-unstable, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  networking.wireless.enable = false; # For Network Manager

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.tailscale.enable = true;


  fonts.fontconfig.enable = true;
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    nerdfonts
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

    emacs = {
      enable = true;
      package = pkgs.emacs;
    };
 };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    unstable.alacritty
    bandwhich  # CLI utility for displaying current network utilization by process, connection and remote IP or hostname
    unstable.brave
    calibre # ebook reader
    unstable.chromium
    dino
    docker
    docker-compose
    unstable.firefox
    flameshot
    unstable.google-chrome
    gucharmap
    imagemagick
    jitsi
    unstable.kitty
    unstable.microsoft-edge
    mkcert
    unstable.mosh
    mullvad-vpn
    multimarkdown
    nrfdfuConfigured
    onedrive
    qdirstat  # Graphical disk usage analyzer
    starship
    synology-drive-client
    tailscale
    vagrant
    vscodeConfigured
    # yubioath-flutter # TODO: revisit later when its NOT broken (2023-05-17)
    # yubikey-manager
    # yubikey-personalization-gui
    # yubico-piv-tool
    zotero
    zoxide  # https://github.com/ajeetdsouza/zoxide
    unstable.zulip
  ] ++ (if stdenv.isx86_64 then [
    unstable._1password-gui
    audacity
    barrier  # oss version of Synergy
    cider  # music client for apple music
    discord
    unstable.element-desktop
    unstable.element-web
    gimp
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.arcmenu
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.openweather
    gnomeExtensions.refresh-wifi-connections
    gnomeExtensions.vitals
    libreoffice
    obs-studio
    unstable.signal-desktop
    unstable.slack
    tdesktop
    unstable.teams  # Microsoft garbage
    unstable.virtualbox
    vlc
    unstable.webex
    wireshark
    youtube-dl
    unstable.zoom-us
  ] else [ ]);
}
