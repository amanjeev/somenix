{ lib, config, pkgs, callPackage, ... }:


let
  home-manager = builtins.fetchGit {  # last updated: 2021-02-05
    # git ls-remote https://github.com/rycee/home-manager release-21.11
    url = "https://github.com/rycee/home-manager.git";
    ref = "release-21.11";
    rev = "a8d00f5c038cf7ec54e7dac9c57b171c1217f008";
  };

  nixos-hardware = builtins.fetchGit {  # last updated: 2022-03-19
    # git ls-remote git@github.com:NixOS/nixos-hardware.git master
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "32f61571b486efc987baca553fb35df22532ba63";
  };

  nixos-unstable = import (builtins.fetchGit {  # last updated: 2022-03-01
    # git ls-remote https://github.com/NixOS/nixpkgs nixpkgs-unstable
    url = "https://github.com/NixOS/nixpkgs";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "3eb07eeafb52bcbf02ce800f032f18d666a9498d";
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
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    tailscale = {
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
          middleEmulation = true;
          tapping = true;
        };
      };
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}
