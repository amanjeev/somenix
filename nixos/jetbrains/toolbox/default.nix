{ pkgs, stdenv, fetchurl, ... }:
let
  name = "jetbrains-toolbox";
  version = "1.19.7784";
  sha256 = "7391afbad4e477875024ee73021b264993fcf91a47d073ae57ab5852dca6abd1";

  jetbrains-toolbox-src = stdenv.mkDerivation {
    name = "${name}-src";

    src = fetchurl {
        url = "https://download.jetbrains.com/toolbox/${name}-${version}.tar.gz";
        inherit sha256;
    };

    installPhase = ''
        #mkdir -p $out/bin
        cp jetbrains-toolbox $out
    '';
  };

  jetbrains-toolbox-f = extraPkgs: pkgs.appimageTools.wrapType2 {
    inherit name;

    src = jetbrains-toolbox-src;

    extraPkgs = pkgs: with pkgs; [
      libcef
    ] ++ extraPkgs;

    meta = with stdenv.lib; {
      description = "A toolbox to manage JetBrains products";
      longDescription = ''
      The JetBrains Toolbox lets you install and manage JetBrains Products in muiltiple versions.
      '';
      homepage = "https://www.jetbrains.com/toolbox/";
      platforms = platforms.all;
    };
  };
  makeWithExtraPackages = f: origArgs:
    let origRes = f origArgs;
    in origRes // { withExtraPkgs = newArgs: (f  newArgs); };

in makeWithExtraPackages jetbrains-toolbox-f []