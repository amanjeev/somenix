#!/usr/bin/env fish

set pkgs "topgrade" \
    "alacritty" \
    "bat" \
    "cargo-flamegraph" \
    "cargo-temp" \
    "du-dust" \
    "exa" \
    "fd" \
    "flamegraph" \
    "fx" \
    "git-extras" \
    "hyperfine" \
    "mdbook" \
    "procs" \
    "ripgrep" \
    "ripgrep-all" \
    "sd" \
    "starship"


for pkg in $pkgs
    nix profile install "nixpkgs#$pkg"
end
