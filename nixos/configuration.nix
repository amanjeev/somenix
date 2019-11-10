# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, callPackage, ... }:


let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "dff5f07952e61da708dc8b348ea677414e992215"; 
    ref = "release-19.09";
  };
in
{
  

  imports = [ 
      "${home-manager}/nixos"
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home.nix
    ];


  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "wolfhowl"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  networking.useDHCP = false;
  networking.interfaces.enp0s20f0u1u2u1.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #home-manager
    slack
    vscode
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  #services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.libinput.naturalScrolling = false;
  services.xserver.libinput.middleEmulation = true;
  services.xserver.libinput.tapping = true;

  # Enable the KDE Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.default = "gnome3";
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome3.enable = true;

  # This is the way to activate some Gnome 3 modules
  services.xserver.desktopManager.gnome3.sessionPath = with pkgs.gnome3; [ gpaste ];
  services.xserver.xkbOptions = "ctrl:swapcaps"; # overriden by gnome (must be set using gnome tweak tool)

  #services.xserver.desktopManager.default = "xfce";
  #services.xserver.desktopManager.xterm.enable = false;
  #services.xserver.desktopManager.xfce.enable = true;
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aj = {
    isNormalUser = true;
    home = "/home/aj";
    description = "Amanjeev Sethi";
    uid = 1000;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

