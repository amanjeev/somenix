# NixOS Configs using Flakes

## How to change and install
1. Clone this repo
2. For a new machine
    - add new platform in directory under `./platform/<machine>`
    - make appropriate changes from `configuration.nix` and `hadrware-configuration.nix`
    - add the machine to `flake.nix`
3. Run the `nixos-rebuild`: `sudo nixos-rebuild switch --install-bootloader --flake .#<machine>`
4. Move `./confs` files to their appropriate locations

## Gratitude

- [Spacekookie](https://twitter.com/spacekookie) for introducing me and giving me my first NixOS config to copy
- [Ana, Hoverbear](https://twitter.com/a_hoverbear) for showing me the light of Nix Flakes and giving me the setup to copy
- [Graham](https://twitter.com/grhmc/) on being in the NixOS community and constantly improving it
- NixOS folks who constantly improve things
- Friends of this land who help me out when I have questions