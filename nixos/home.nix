{ lib, config, pkgs, home-manager, nixos-unstable, ... }:

{  
  
  home-manager.users.aj = { ... }: {
    imports = [
      ( import ./pkgs { lib = lib; config = config; pkgs = pkgs; nixos-unstable = nixos-unstable; })
      ( import ./gnome-extensions {lib = lib; config = config; pkgs = pkgs; nixos-unstable = nixos-unstable;} )
    ];
  };

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;
}
