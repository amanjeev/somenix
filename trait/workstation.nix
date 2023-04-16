{ config, pkgs, lib, ... }:

{
  networking.wireless.enable = false; # For Network Manager

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
    alacritty
    bandwhich  # CLI utility for displaying current network utilization by process, connection and remote IP or hostname
    brave
    calibre # ebook reader
    chromium
    dino
    docker
    docker-compose
    firefox
    flameshot
    google-chrome
    imagemagick
    jitsi
    kitty
    microsoft-edge
    mkcert
    mosh
    mullvad-vpn
    multimarkdown
    onedrive
    qdirstat  # Graphical disk usage analyzer
    starship
    synology-drive-client
    vscodeConfigured
    yubioath-flutter
    yubikey-manager
    yubikey-personalization-gui
    yubico-piv-tool
    zotero
    zoxide  # https://github.com/ajeetdsouza/zoxide
    zulip
  ] ++ (if stdenv.isx86_64 then [
    _1password-gui
    barrier  # oss version of Synergy
    discord
    element-desktop
    element-web
    gimp
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.applications-menu
    gnomeExtensions.dash-to-dock
    # gnomeExtensions.easyScreenCast
    gnomeExtensions.emoji-selector
    gnomeExtensions.extension-list
    gnomeExtensions.net-speed-simplified
    gnomeExtensions.openweather
    gnomeExtensions.refresh-wifi-connections
    gnomeExtensions.topicons-plus
    gnomeExtensions.vitals
    libreoffice
    obs-studio
    signal-desktop
    slack
    spotify
    tdesktop
    teams  # Microsoft garbage
    vlc
    wireshark
    youtube-dl
    zoom-us
  ] else [ ]);
}
