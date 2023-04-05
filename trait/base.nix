{ config, pkgs, lib, ... }:

{
  fileSystems."/scratch" = { fsType = "tmpfs"; };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  environment.systemPackages = with pkgs; [
    alacritty
    any-nix-shell
    arp-scan
    bat  # a cat replacement with highlighting
    bandwhich  # CLI utility for displaying current network utilization by process, connection and remote IP or hostname
    barrier  # oss version of Synergy
    bind
    bottom  # Yet another cross-platform graphical process/system monitor. https://github.com/ClementTsang/bottom
    brave
    broot  # An interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands https://github.com/Canop/broot
    calibre # ebook reader
    chromium
    conda
    curl
    deja-dup
    dino
    direnv
    discord
    dnsutils
    docker
    docker-compose
    du-dust  # du replacement in rust https://github.com/bootandy/dust
    element-desktop
    element-web
    exa  # ls replacement in rust https://github.com/ogham/exa
    fd  # find replacement in rust https://github.com/sharkdp/fd
    file
    firefox
    fish
    flameshot
    fzf # general-purpose cli fuzzy finder
    gcc
    gdb
    gimp
    gitAndTools.hub
    gnucash
    gnum4
    gnumake
    gnupg
    google-chrome
    grex
    gtk3
    haskellPackages.digest
    hidapi
    htop
    hyperfine # time replacement in rust cli benchmarking tool https://github.com/sharkdp/hyperfine
    imagemagick
    inconsolata  # font
    iosevka  # font
    iosevka-bin  # font
    jid  # interactive wrapper for jq
    jitsi
    jq
    kbfs
    killall
    kitty
    libapparmor
    libguestfs  # Tools for accessing and modifying virtual machine disk images
    libreoffice
    libvirt  # qemu kvm etc.
    libvirt-glib
    lm_sensors
    lsd  # next gen ls https://github.com/Peltoche/lsd
    lsof
    microsoft-edge
    mosh
    multimarkdown
    mkcert
    mullvad-vpn
    niv
    nmap
    obs-studio
    oh-my-zsh
    openfortivpn
    pandoc
    patchelf
    pkg-config
    podman  # docker replacement, daemonless
    podman-compose  # docker-compose replacement
    postman
    procs  # ps replacement in rust https://github.com/dalance/procs
    python39Full
    python39Packages.pip
    python39Packages.virtualenv
    python39Packages.virtualenvwrapper
    qdirstat  # Graphical disk usage analyzer
    restic
    ripgrep
    ripgrep-all
    sd  # sed replacement in rust https://github.com/chmln/sd
    signal-desktop
    skim
    skypeforlinux
    slack
    smartmontools
    socat
    starship  # minimal, blazing fast, and extremely customizable prompt for any shell
    synology-drive-client
    tdesktop
    tealdeer  # is a very fast implementation of tldr, a command-line program for displaying simplified, example based and community-driven man pages
    teams  # Microsoft garbage
    thefuck
    tmux
    tmuxPlugins.continuum
    tmuxPlugins.logging
    tmuxPlugins.resurrect
    tmuxPlugins.sidebar
    tmuxPlugins.urlview
    tmuxPlugins.yank
    tokei  # displays statistics about your code
    topgrade
    udev
    unzip
    vim
    vlc
    vokoscreen
    wget
    wireshark
    xe-guest-utilities
    youtube-dl
    yubioath-flutter
    yubikey-manager
    yubikey-personalization-gui
    yubico-piv-tool
    zoom-us
    zotero
    zoxide  # https://github.com/ajeetdsouza/zoxide
    zulip
  ] ++ [
    gnomeExtensions.appindicator
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.system-monitor
  ] ++ [
    (emacs.pkgs.withPackages (epkgs: (with epkgs.melpaStablePackages; [
      ace-window  # which window to switch
      beacon  # light that follows your cursor
      color-theme-sanityinc-tomorrow
      company
      counsel  # provides versions of common Emacs commands that are customised to make the best use of ivy
      diffview
      direnv
      discover  # Discover more of emacs using context menus
      exec-path-from-shell  # ensure environment variables inside Emacs look the same as in the user's shell
      fish-mode
      flycheck  # replacement for flymake, syntax checker
      fzf
      iedit  # edit multiple regions simult.
      lsp-mode  # spinner version incorrect so fails build
      magit  # git
      markdown-mode
      nix-mode
      notmuch
      rust-mode
      smartscan
      smex
      sublimity
      swiper  # a generic completion frontend for Emacs, Swiper
      symon  #  tiny graphical system monitor
      use-package
      visual-fill-column
      visual-regexp
      which-key  # Emacs package that displays available keybindings in popup
      yaml-mode
    ])))
  ];

  environment.shellAliases = { };
  environment.variables = {
  };
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  programs.command-not-found.enable = true;

  programs.fish = {
    enable = true;
    
  };

  programs.bash.promptInit = ''
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';
  programs.bash.shellInit = ''
  '';
  programs.bash.loginShellInit = ''
    
  '';
  programs.bash.interactiveShellInit = ''
    
  '';

  security.sudo.wheelNeedsPassword = false;

  # Use edge NixOS.
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.package = pkgs.nixUnstable;
}
