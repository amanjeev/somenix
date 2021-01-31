{ lib, config, pkgs, callPackage, ... }:


let
  home-manager = builtins.fetchGit {  # last updated: 2020-01-25
    # git ls-remote https://github.com/rycee/home-manager release-20.09
    url = "https://github.com/rycee/home-manager.git";
    ref = "release-20.09";
    rev = "91bd34620d73340be03642279ee0d1c64110ee6c";
  };

  nixos-hardware = builtins.fetchGit {  # last updated: 2020-01-25
    # git ls-remote git@github.com:NixOS/nixos-hardware.git master
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "a0d8383c422f85f37fccee5af74b1cb4b52287d9";
  };

  nixos-unstable = import (builtins.fetchGit {  # last updated: 2020-01-31
    # git ls-remote https://github.com/NixOS/nixpkgs nixpkgs-unstable
    url = "https://github.com/NixOS/nixpkgs";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "1b77b735ea70c3dfbdab3eaa79aee48d75d3e162";
  }) { config = { allowUnfree = true; }; };
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    "${home-manager}/nixos"
    # TODO: change this for other machines
    "${nixos-hardware}/lenovo/thinkpad/x1/6th-gen"
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
    hostName = "torontula";
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
      enp0s20f0u2 = { useDHCP = true; };
      enp0s31f6 = { useDHCP = true; };
      enp59s0u1u1 = { useDHCP = true; };

    };
    networkmanager = {
      enable = true;
      # Plausible MAC randomization
      ethernet.macAddress = "random";
      wifi.macAddress = "random";
      extraConfig = ''
        [connection-extra]
        ethernet.generate-mac-address-mask=FE:FF:FF:00:00:00
        wifi.generate-mac-address-mask=FE:FF:FF:00:00:00
      '';
    };

    extraHosts = ''
    0.0.0.0 candig.local
    0.0.0.0 keycloak
    0.0.0.0 candigv2.calculquebec.local
    0.0.0.0 candigauthv2.calculquebec.local
    0.0.0.0 candigauth.local
    0.0.0.0 candig.local
    '';
    
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
      libinput = {
        enable = true;
        naturalScrolling = false;
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
