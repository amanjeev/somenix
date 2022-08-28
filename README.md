# NixOS Configs using Flakes

## How to change and install
1. Clone this repo
2. For a new machine
    - add new platform in directory under `./platform/<machine>`
    - make appropriate changes from `configuration.nix` and `hadrware-configuration.nix`
3. Run the `nixos-rebuild`: `sudo nixos-rebuild switch --flakes .#<machine>`
4. Move `./confs` files to their appropriate locations
