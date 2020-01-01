{lib, config, pkgs, ...}:

{
  nixpkgs.config.allowUnfree = true;  # no shit
  
  home.file.".zshrc".source = ./confs/.zshrc;
  home.file.".tmux.conf".source = ./confs/.tmux.conf;
  home.file.".emacs".source = ./confs/.emacs;
  home.file."init.el".source = ./confs/.emacs;
  home.file."sickkids-fortigate".source = ./confs/sickkids-fortigate;
  xdg.configFile."kitty/kitty.conf".source = ./confs/kitty.conf;


  home.packages = with pkgs; [
    alacritty
    any-nix-shell
    arp-scan
    brave
    bat # a cat replacement with highlighting
    chromium
    curl
    discord
    docker
    docker-compose
    exa # ls replacement in rust
    firefox
    flameshot
    fzf # general-purpose cli fuzzy finder
    gcc
    gdb
    gimp
    git
    gnumake
    gnupg
    google-chrome
    hexchat
    htop
    hyperfine # cli benchmarking tool
    imagemagick
    jetbrains.clion
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.ruby-mine
    jetbrains.webstorm
    jq
    kitty
    libreoffice
    liferea # rss reader
    mullvad-vpn
    mkcert
    nmap
    oh-my-zsh
    openfortivpn
    postman
    python3Full
    python37Packages.pip
    python37Packages.syncthing-gtk
    python37Packages.virtualenv
    python37Packages.virtualenvwrapper
    ripgrep
    ripgrep-all
    rustup
    signal-desktop
    #skypeforlinux
    slack
    starship # minimal, blazing fast, and extremely customizable prompt for any shell
    syncthing
    tdesktop
    tmux
    tmuxPlugins.continuum
    tmuxPlugins.logging
    tmuxPlugins.resurrect
    tmuxPlugins.sidebar
    tmuxPlugins.urlview
    tmuxPlugins.yank
    unzip
    vim
    vlc
    vscode
    weechat
    wget
    wireshark
    youtube-dl
    zoom-us
  ];
 
  programs.git = {
    enable = true;
    userName = "Amanjeev Sethi";
    userEmail = "aj@amanjeev.com";
  };

  services.emacs.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
      epkgs.iedit
      epkgs.beacon
      epkgs.exec-path-from-shell
      epkgs.flycheck
      epkgs.counsel
      epkgs.swiper
      epkgs.ace-window
      epkgs.org-bullets
      epkgs.which-key
      epkgs.try
      epkgs.org
      epkgs.org-ac
      epkgs.use-package-chords
      epkgs.use-package
      epkgs.highlight-symbol
      epkgs.monokai-theme
      epkgs.powerline-evil
      epkgs.powerline
      epkgs.symon
      epkgs.multi-term
      epkgs.magithub
      epkgs.rust-mode
      epkgs.json-mode
      epkgs.evil-nerd-commenter
      epkgs.multiple-cursors
      epkgs.rainbow-identifiers
      epkgs.rainbow-delimiters
      epkgs.rainbow-mode
      epkgs.undo-tree
      epkgs.visual-regexp
      epkgs.ace-jump-mode
      epkgs.minimap
      epkgs.sublimity
      epkgs.god-mode
      epkgs.magit
      epkgs.diffview
      epkgs.python
    ];
  };

  programs.firefox = {
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      cookie-autodelete
      https-everywhere
      privacy-badger
    ];
  };
}

