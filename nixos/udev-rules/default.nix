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
ATTRS{idVendor}=="1366", ENV{ID_MM_DEVICE_IGNORE}="1", TAG+="uaccess"
'';
    destination = "/etc/udev/rules.d/50-oxidize-global.rules";
  };

  wallyKeyboardRules = pkgs.writeTextFile {
    name = "wally-rules";
    text = ''
# Teensy rules for the Ergodox EZ
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

# STM32 rules for the Moonlander and Planck EZ
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
    MODE:="0666", \
    SYMLINK+="stm32_dfu"
'';
    destination = "/etc/udev/rules.d/50-wally.rules";
  };

  in

{
  # Installs everything in that package's /etc/udev/rules.d and /lib/udev/rules.d
  services.udev.packages = with pkgs; [
    yubikey-personalization
    libu2f-host
    extraUdevRules
    wallyKeyboardRules
  ];
}
