{lib, config, pkgs, ...}:

{
  nixpkgs.config.allowUnfree = true;  # no shit
  
  home.file.".tmux.conf".source = ./confs/tmux.conf;
  home.file.".emacs".source = ./confs/init.el;
  home.file."sickkids-fortigate".source = ./confs/sickkids-fortigate;
  xdg.configFile."kitty/kitty.conf".source = ./confs/kitty.conf;
  xdg.configFile."alacritty/alacritty.yml".source = ./confs/alacritty.yml;
  xdg.configFile."starship.toml".source = ./confs/starship.toml;

  home.packages = with pkgs; [
    alacritty
    any-nix-shell
    arp-scan
    barrier # oss version of Synergy
    bat # a cat replacement with highlighting
    bind
    calibre # ebook reader
    brave
    chromium
    conda
    curl
    dino
    direnv
    discord
    dnsutils
    docker
    docker-compose
    du-dust  # du replacement in rust https://github.com/bootandy/dust
    exa  # ls replacement in rust https://github.com/ogham/exa
    fd  # find replacement in rust https://github.com/sharkdp/fd
    feedreader
    firefox
    flameshot
    fzf # general-purpose cli fuzzy finder
    gcc
    gdb
    gimp
    gnucash
    gnumake
    gnupg
    google-chrome
    hexchat
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
    kitty
    libreoffice
    mullvad-vpn
    multimarkdown
    mkcert
    nmap
    obs-studio
    oh-my-zsh
    openfortivpn
    pandoc
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
    skypeforlinux
    slack
    socat
    starship  # minimal, blazing fast, and extremely customizable prompt for any shell
    syncthing
    tdesktop
    thefuck
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
    vokoscreen
    vscode
    weechat
    wget
    wireshark
    xe-guest-utilities
    youtube-dl
    yubioath-desktop
    yubikey-manager
    yubikey-personalization-gui
    yubico-piv-tool
    zoom-us
    zotero
  ];
 
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Amanjeev Sethi";
    userEmail = "aj@amanjeev.com";
    ignores = [ "*~" "*.swp" "*sync-conflict*" ".idea" ".vscode" ];
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

