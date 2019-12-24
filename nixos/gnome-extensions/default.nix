{lib, config, pkgs, ...}:

{
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    impatience
    sound-output-device-chooser
    system-monitor
    topicons-plus
  ];
}

