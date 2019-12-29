{ pkgs, home-manager, ... }:

{  
  
  home-manager.users.aj = { ... }: {
    imports = [
      ./pkgs
      ./gnome-extensions
    ];
  };

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;
}
