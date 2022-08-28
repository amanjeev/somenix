{ config, pkgs, lib, ... }:

{
  fileSystems."/scratch" = { fsType = "tmpfs"; };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  environment.systemPackages = with pkgs; [
    # Shell utilities
    patchelf
    direnv
    nix-direnv
    git
    jq
    fzf
    ripgrep
    lsof
    htop
    bat
    grex
    broot
    bottom
    fd
    sd
    fio
    hyperfine
    tokei
    bandwhich
    killall
    gptfdisk
    fio
    smartmontools
    deja-dup
    fish
    gtk3
    haskellPackages.digest
    hidapi
    libguestfs  # Tools for accessing and modifying virtual machine disk images
    udev
    pkg-config
    libvirt  # qemu kvm etc.
    libvirt-glib
    lm_sensors
  ];
  environment.shellAliases = { };
  environment.variables = {
  };
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

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

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "19.09"; # Did you read the comment?
}
