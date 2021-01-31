{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    # make toolbox depend on fontPackages to use all installed fonts
    (jetbrains-toolbox.withExtraPkgs config.fonts.fontconfig.confPackages)
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    jetbrains-toolbox = pkgs.callPackage ./toolbox {};
  };
}