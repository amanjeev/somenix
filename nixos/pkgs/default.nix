{pkgs, ...}:

{
  home.file.".tmux.conf".source = ./confs/.tmux.conf;
  home.file.".emacs".source = ./confs/.emacs;

  home.packages = with pkgs; [
    alacritty
    brave
    curl
    flameshot
    git
    gnupg
    htop
    rustup
    signal-desktop
    tmux
    vim
    wget    
  ];

  programs.git = {
    enable = true;
    userName = "Amanjeev Sethi";
    userEmail = "aj@amanjeev.com";
  };

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
}

