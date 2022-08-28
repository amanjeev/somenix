{ lib, pkgs, ... }:

{
  users.users.aj = {
    isNormalUser = true;
    home = "/home/aj";
    description = "Amanjeev Sethi";
    uid = 1000;
    useDefaultShell = true;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker" "vboxusers" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwFBO34qO/reUTFKrax7nuJwKEB0rAk3y5c6LMGF8ah aj@amanjeev.com wolfhowl"
    ];
  };

  users.defaultUserShell = pkgs.fish;
}
