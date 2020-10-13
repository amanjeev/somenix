{lib, config, pkgs, nixos-unstable, ...}:

{
  nixpkgs.config.allowUnfree = true;  # no shit
  
  home.file.".tmux.conf".source = ./confs/tmux.conf;
  home.file.".emacs".source = ./confs/init.el;
  home.file."sickkids-fortigate".source = ./confs/sickkids-fortigate;
  home.file.".zshrc".source = ./confs/zshrc;
  home.file.".bashrc".source = ./confs/bashrc;
  xdg.configFile."kitty/kitty.conf".source = ./confs/kitty.conf;
  xdg.configFile."alacritty/alacritty.yml".source = ./confs/alacritty.yml;
  xdg.configFile."starship.toml".source = ./confs/starship.toml;
  xdg.configFile."fish/functions/__bass.py".source = ./confs/fish/functions/__bass.py;
  xdg.configFile."fish/functions/bass.fish".source = ./confs/fish/functions/bass.fish;

  home.packages = with pkgs; [
    any-nix-shell
    arp-scan
    bandwhich  # CLI utility for displaying current network utilization by process, connection and remote IP or hostname
    barrier  # oss version of Synergy
    bind
    chromium
    conda
    curl
    dino
    dnsutils
    docker
    docker-compose
    du-dust  # du replacement in rust https://github.com/bootandy/dust
    exa  # ls replacement in rust https://github.com/ogham/exa
    fd  # find replacement in rust https://github.com/sharkdp/fd
    feedreader
    file
    firefox
    flameshot
    fzf # general-purpose cli fuzzy finder
    gcc
    gdb
    gimp
    gnucash
    gnum4
    gnumake
    gnupg
    google-chrome
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
    libreoffice
    lsof
    mosh
    multimarkdown
    mkcert
    nixos-unstable.alacritty
    nixos-unstable.bat  # a cat replacement with highlighting
    nixos-unstable.brave
    nixos-unstable.calibre # ebook reader
    nixos-unstable.direnv
    nixos-unstable.discord
    nixos-unstable.kitty
    nixos-unstable.mullvad-vpn
    nixos-unstable.openconnect  # UHN VPN client
    nixos-unstable.skypeforlinux
    nixos-unstable.slack
    nixos-unstable.vscode
    nixos-unstable.zoom-us
    nixos-unstable.zotero
    nmap
    obs-studio
    oh-my-zsh
    openfortivpn
    pandoc
    podman  # docker replacement, daemonless
    podman-compose  # docker-compose replacement
    postman
    procs  # ps replacement in rust https://github.com/dalance/procs
    python38Full
    python38Packages.pip
    python38Packages.syncthing-gtk
    python38Packages.virtualenv
    python38Packages.virtualenvwrapper
    riot-desktop
    riot-web
    ripgrep
    ripgrep-all
    rustup
    sd  # sed replacement in rust https://github.com/chmln/sd
    signal-desktop
    socat
    starship  # minimal, blazing fast, and extremely customizable prompt for any shell
    syncthing
    tdesktop
    tealdeer  # is a very fast implementation of tldr, a command-line program for displaying simplified, example based and community-driven man pages
    teams
    thefuck
    tmux
    tmuxPlugins.continuum
    tmuxPlugins.logging
    tmuxPlugins.resurrect
    tmuxPlugins.sidebar
    tmuxPlugins.urlview
    tmuxPlugins.yank
    tokei  # displays statistics about your code
    unzip
    vim
    vlc
    vokoscreen
    wget
    wireshark
    xe-guest-utilities
    youtube-dl
    ytop
    yubioath-desktop
    yubikey-manager
    yubikey-personalization-gui
    yubico-piv-tool
  ];
 
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Amanjeev Sethi";
    userEmail = "aj@amanjeev.com";
    ignores = [ "*~" "*.swp" "*sync-conflict*" ".idea" ".vscode" ];
    signing = {
      key = "aj@amanjeev.com";  # is this true?
      signByDefault = true;
    };
    extraConfig = {
      core = {
        editor = "emacs";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      };
      push = {
        default = "matching";
      };
      sendemail = {
        smtpencryption = "tls";
        smtpserver = "smtp.fastmail.com";
        smtpuser = "aj@amanjeev.com";
        smtpserverport = "587";
        suppresscc = "self";
      };
      color = {
        ui = "auto";
      };
      github = {
        user = "amanjeev";
      };
    };
  };

  programs.command-not-found.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.ace-window  # which window to switch
      epkgs.beacon  # light that follows your cursor
      epkgs.color-theme-sanityinc-tomorrow
      epkgs.company
      epkgs.company-lsp
      epkgs.counsel  # provides versions of common Emacs commands that are customised to make the best use of ivy
      epkgs.diffview
      epkgs.direnv
      epkgs.discover  # Discover more of emacs using context menus
      epkgs.exec-path-from-shell  # ensure environment variables inside Emacs look the same as in the user's shell
      epkgs.fish-mode
      epkgs.flycheck  # replacement for flymake, syntax checker
      epkgs.fzf
      epkgs.iedit  # edit multiple regions simult.
      epkgs.lsp-mode
      epkgs.magit  # git
      epkgs.markdown-mode
      epkgs.nix-mode
      epkgs.notmuch
      epkgs.org  # notes, planning, todos
      epkgs.org-ac  # auto-complete sources for org-mode      
      epkgs.org-bullets  # Show org-mode bullets as UTF-8 characters
      epkgs.python-mode
      epkgs.rainbow-mode
      epkgs.rainbow-delimiters  # match parantheses
      epkgs.rust-mode
      epkgs.smartscan
      epkgs.smex
      epkgs.sublimity
      epkgs.swiper  # a generic completion frontend for Emacs, Swiper
      epkgs.symon  #  tiny graphical system monitor
      epkgs.undo-tree  # Treat undo history as a tree
      epkgs.use-package
      epkgs.visual-fill-column
      epkgs.visual-regexp
      epkgs.which-key  # Emacs package that displays available keybindings in popup
      epkgs.yaml-mode
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

