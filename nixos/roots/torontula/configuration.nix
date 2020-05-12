{ lib, config, pkgs, callPackage, ... }:


let
  home-manager = builtins.fetchGit {  # last updated: 2020-04-30
    # git ls-remote https://github.com/rycee/home-manager release-20.03
    url = "https://github.com/rycee/home-manager.git";
    ref = "release-20.03";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
  };

  nixos-hardware = builtins.fetchGit {  # last updated: 2020-05-09
    # git ls-remote https://github.com/NixOS/nixos-hardware master
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "8e8e65ba45e8374fcb6258f9606910a77b68dbe0";
  };
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    "${home-manager}/nixos"
    # TODO: change this for other machines
    "${nixos-hardware}/lenovo/thinkpad/x1/6th-gen"
    ./hardware-configuration.nix
    ../../home.nix
    ../../common.nix
  ];

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
