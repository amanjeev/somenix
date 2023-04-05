{ config, pkgs, lib, ... }:

{
  fileSystems."/scratch" = { fsType = "tmpfs"; };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  environment.systemPackages = with pkgs; [
    any-nix-shell
    arp-scan
    bat  # a cat replacement with highlighting
    bind
    curl
    dnsutils
    file
    grex
    gtk3
    hidapi
    htop
    hyperfine # time replacement in rust cli benchmarking tool https://github.com/sharkdp/hyperfine
    killall
    libapparmor
    libvirt  # qemu kvm etc.
    libvirt-glib
    lm_sensors
    lsof
    niv
    nmap
    patchelf
    pkg-config
    postman
    socat
    tmux
    tmuxPlugins.continuum
    tmuxPlugins.logging
    tmuxPlugins.resurrect
    tmuxPlugins.sidebar
    tmuxPlugins.urlview
    tmuxPlugins.yank
    udev
    unzip
    vim
    wget
  ] ++ [
    ((emacsPackagesFor emacs).emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
      ace-window  # which window to switch
      beacon  # light that follows your cursor
      color-theme-sanityinc-tomorrow
      base16-theme
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
