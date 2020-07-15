# Provides a custom set of udev rules, for hardware I use often (mostly debug
# probes and dev kits).

{ config, pkgs, ... }:

let
  extraUdevRules = pkgs.writeTextFile {
    name = "oxidize-rules";
    text = ''
# udev rules to allow access to USB devices as a non-root user

# nRF52840 Dongle in bootloader mode
ATTRS{idVendor}=="1915", ATTRS{idProduct}=="521f", TAG+="uaccess"

# nRF52840 Dongle applications
ATTRS{idVendor}=="2020", TAG+="uaccess"

# nRF52840 Development Kit
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1015", TAG+="uaccess"
'';
    destination = "/etc/udev/rules.d/50-oxidize-global.rules";
  };
  in

{
  # Installs everything in that package's /etc/udev/rules.d and /lib/udev/rules.d
  services.udev.packages = with pkgs; [
    yubikey-personalization
    libu2f-host
    extraUdevRules
  ];
}
