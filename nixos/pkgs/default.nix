{lib, config, pkgs, nixos-unstable, ...}:

{
  nixpkgs.config.allowUnfree = true;  # no shit
  
  home.file.".tmux.conf".source = ./confs/tmux.conf;
  home.file.".emacs".source = ./confs/init.el;
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
    file
    firefox
    flameshot
    fzf # general-purpose cli fuzzy finder
    gcc
    gdb
    getmail
    gimp
    gitAndTools.hub
    gnucash
    gnum4
    gnumake
    gnupg
    google-chrome
    htop
    imagemagick
    inconsolata  # font
    iosevka  # font
    iosevka-bin  # font
    jid  # interactive wrapper for jq
    jitsi
    jq
    kbfs
    libapparmor
    libreoffice
    lsof
    mosh
    multimarkdown
    mkcert
    niv
    nixos-unstable.alacritty
    nixos-unstable.bat  # a cat replacement with highlighting
    nixos-unstable.bottom  # Yet another cross-platform graphical process/system monitor. https://github.com/ClementTsang/bottom
    nixos-unstable.brave
    nixos-unstable.broot  # An interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands https://github.com/Canop/broot
    nixos-unstable.calibre # ebook reader
    nixos-unstable.direnv
    nixos-unstable.discord
    nixos-unstable.du-dust  # du replacement in rust https://github.com/bootandy/dust
    nixos-unstable.exa  # ls replacement in rust https://github.com/ogham/exa
    nixos-unstable.fd  # find replacement in rust https://github.com/sharkdp/fd
    nixos-unstable.hyperfine # time replacement in rust cli benchmarking tool https://github.com/sharkdp/hyperfine
    nixos-unstable.kitty
    nixos-unstable.lsd  # next gen ls https://github.com/Peltoche/lsd
    nixos-unstable.mullvad-vpn
    nixos-unstable.obsidian
    nixos-unstable.openconnect  # UHN VPN client
    nixos-unstable.procs  # ps replacement in rust https://github.com/dalance/procs
    nixos-unstable.qdirstat  # Graphical disk usage analyzer
    nixos-unstable.ripgrep
    nixos-unstable.ripgrep-all
    nixos-unstable.rustup
    nixos-unstable.rust-analyzer
    nixos-unstable.sd  # sed replacement in rust https://github.com/chmln/sd
    nixos-unstable.skypeforlinux
    nixos-unstable.slack
    nixos-unstable.topgrade
    nixos-unstable.zoom-us
    nixos-unstable.zotero
    nixos-unstable.zoxide  # https://github.com/ajeetdsouza/zoxide
    nmap
    obs-studio
    oh-my-zsh
    openfortivpn
    pandoc
    podman  # docker replacement, daemonless
    podman-compose  # docker-compose replacement
    postman
    python39Full
    python39Packages.pip
    python39Packages.virtualenv
    python39Packages.virtualenvwrapper
    restic
    element-desktop
    element-web
    signal-desktop
    socat
    starship  # minimal, blazing fast, and extremely customizable prompt for any shell
    syncthing
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
    unzip
    vim
    vlc
    vokoscreen
    wget
    wireshark
    xe-guest-utilities
    youtube-dl
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
      epkgs.counsel  # provides versions of common Emacs commands that are customised to make the best use of ivy
      epkgs.diffview
      epkgs.direnv
      epkgs.discover  # Discover more of emacs using context menus
      epkgs.exec-path-from-shell  # ensure environment variables inside Emacs look the same as in the user's shell
      epkgs.fish-mode
      epkgs.flycheck  # replacement for flymake, syntax checker
      epkgs.fzf
      epkgs.iedit  # edit multiple regions simult.
      # epkgs.lsp-mode  # spinner version incorrect so fails build
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

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode-remote.remote-ssh
    ];
    userSettings = {
      "editor.codeLensFontFamily" = "Iosevka";
      "editor.fontSize" = 19;
      "editor.fontFamily" = "Iosevka";
      "editor.minimap.enabled" = false;
      "files.autoSave" = "on";
      "terminal.integrated.fontFamily" = "Iosevka";
      "terminal.integrated.defaultProfile.linux" = "fish";
      "terminal.integrated.automationShell.linux" = "fish";
      "terminal.integrated.shell.linux" = "fish";
      "remote.SSH.useLocalServer" = false;
      "remote.SSH.remotePlatform" = {
        "varg-internal" = "linux";
      };
    };
  };
}

