{ lib, config, pkgs, callPackage, ... }:


let
  home-manager = builtins.fetchGit {  # last updated: 2020-07-06
    # git ls-remote https://github.com/rycee/home-manager release-20.03
    url = "https://github.com/rycee/home-manager.git";
    ref = "release-20.03";
    rev = "318bc0754ed6370cfcae13183a7f13f7aa4bc73f";
  };

  nixos-hardware = builtins.fetchGit {  # last updated: 2020-08-15
    # git ls-remote https://github.com/NixOS/nixos-hardware master
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "984c72f65312c82be2d20b82345b22c99e0508f0";
  };
  
  nixos-unstable = import (builtins.fetchGit {  # last updated: 2020-09-04
    # git ls-remote https://github.com/nixos/nixpkgs-channels nixpkgs-unstable
    url = "https://github.com/nixos/nixpkgs-channels";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "fd457ecb6cc57d4d22f97328587cb7cd4150c75b";
  }) { config = { allowUnfree = true; }; };
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [ 
    "${home-manager}/nixos"
    # TODO: change this for other machines
    "${nixos-hardware}/dell/xps/13-9370"
    ./hardware-configuration.nix
    ( import ../../home.nix { lib = lib; config = config; pkgs = pkgs; home-manager = home-manager; nixos-unstable = nixos-unstable; })
    ( import ../../common.nix { lib = lib; config = config; pkgs = pkgs; callPackage = callPackage; nixos-unstable = nixos-unstable; })
    ../../udev-rules
  ];

  boot.extraModprobeConfig = "options kvm_intel nested=1";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  networking = {
    hostName = "wolfhowl";
    useDHCP = false;
    wireless = {
      enable = false;  # Enables wireless support via wpa_supplicant.
    };
    interfaces = {
      enp0s20f0u1u2u1 = {
        useDHCP = true;
      };
      wlp2s0 = {
        useDHCP = true;
      };
    };
    networkmanager = {
      enable = true;
      # Plausible MAC randomization
      ethernet.macAddress = "random";
      wifi.macAddress = "random";
      extraConfig = ''
        [connection-extra]
        ethernet.generate-mac-address-mask=FE:FF:FF:11:00:00
        wifi.generate-mac-address-mask=FE:FF:FF:11:00:00
      '';
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
      libinput = {
        enable = true;
        naturalScrolling = true;
        middleEmulation = true;
        tapping = true;
      };
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}
