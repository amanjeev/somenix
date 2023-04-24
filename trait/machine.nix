{ pkgs, ... }:

{
  boot.kernel.sysctl = {
    # TCP Fast Open (TFO)
    "net.ipv4.tcp_fastopen" = 3;
  };
  boot.initrd.availableKernelModules = [
    "usb_storage"
    "nbd"
    "nvme"
  ];
  boot.kernelModules = [
    "coretemp"
  ];
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "aj" ];
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  users.users.aj.extraGroups = [ "libvirtd" ];
  

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];

  #services.tlp.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";
}
