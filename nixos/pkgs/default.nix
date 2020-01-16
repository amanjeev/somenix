{lib, config, pkgs, ...}:

{
  nixpkgs.config.allowUnfree = true;  # no shit
  
  home.file.".tmux.conf".source = ./confs/tmux.conf;
  home.file.".emacs".source = ./confs/init.el;
  home.file."sickkids-fortigate".source = ./confs/sickkids-fortigate;
  xdg.configFile."kitty/kitty.conf".source = ./confs/kitty.conf;

  home.packages = with pkgs; [
    alacritty
    any-nix-shell
    arp-scan
    bat # a cat replacement with highlighting
    bind
    brave
    chromium
    curl
    discord
    dnsutils
    docker
    docker-compose
    exa # ls replacement in rust
    feedreader
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
    jitsi
    jq
    kitty
    libreoffice
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
    riot-desktop
    riot-web
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
    ignores = [ "*~" "*.swp" "*sync-conflict*" ];
    extraConfig = {
      core = {
        editor = "emacs";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      };
      push = {
        default = "matching";
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

  services.emacs.enable = true;

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
      epkgs.discover  # Discover more of emacs using context menus
      epkgs.exec-path-from-shell  # ensure environment variables inside Emacs look the same as in the user's shell
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

