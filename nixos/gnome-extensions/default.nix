{lib, config, pkgs, ...}:

{
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    sound-output-device-chooser
    system-monitor
    topicons-plus
  ];
}

