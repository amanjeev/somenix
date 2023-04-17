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

  services.xserver.xkbOptions = "caps:ctrl_modifier";

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
    lshw
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
    usbutils
    vim
    wget
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
