{ pkgs, home-manager, ... }:

{  
  
  home-manager.users.aj = { ... }: {
    imports = [
      ./pkgs
    ];
  };

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;
}
