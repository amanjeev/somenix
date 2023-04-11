{ config, pkgs, lib, ... }:

{
  fileSystems."/scratch" = { fsType = "tmpfs"; };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  services.udev.extraRules = ''
# Rules for Oryx web flashing and live training
KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

# Legacy rules for live training over webusb (Not needed for firmware v21+)
  # Rule for all ZSA keyboards
  SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
  # Rule for the Moonlander
  SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
  # Rule for the Ergodox EZ
  SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
  # Rule for the Planck EZ
  SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

# Wally Flashing rules for the Ergodox EZ
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

# Wally Flashing rules for the Moonlander and Planck EZ
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
    MODE:="0666", \
    SYMLINK+="stm32_dfu"
  '';

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
    libusb1
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
