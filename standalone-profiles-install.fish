#!/usr/bin/env fish

set pkgs "neovim" "cowsay"

for pkg in $pkgs
    nix profile install "nixpkgs#$pkg"
end
