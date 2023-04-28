{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.clion
    # jetbrains.datagrip
    # jetbrains.goland
    # jetbrains.idea-ultimate
    # jetbrains.pycharm-professional
    # jetbrains.ruby-mine
    # jetbrains.webstorm
  ];

  # CLion requires cargo-xlib.
  environment.noXlibs = lib.mkForce false;

  nixpkgs.config.allowUnfree = true;
}
