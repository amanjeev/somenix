{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-7b92771f-b750-486c-b9df-4e763d269f77".device = "/dev/disk/by-uuid/7b92771f-b750-486c-b9df-4e763d269f77";
  boot.initrd.luks.devices."luks-7b92771f-b750-486c-b9df-4e763d269f77".keyFile = "/crypto_keyfile.bin";

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d35f3a23-1fc3-428d-8ca7-55769233dc8a";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-681f7054-c9e1-42e9-bb5a-e4a427bf4a35".device = "/dev/disk/by-uuid/681f7054-c9e1-42e9-bb5a-e4a427bf4a35";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/6BF4-3992";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/ff3cb9e8-9e12-4781-adac-f7b5460db528"; }
    ];

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

  # networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  time.timeZone = "America/Toronto";
  # Windows wants hardware clock in local time instead of UTC
  time.hardwareClockInLocalTime = true;

  hardware.bluetooth.enable = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}

