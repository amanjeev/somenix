# NixOS and Home Manager configs

## Caveats

1. To install `unfree` packages, use [./nixos/configuration.nix] rather than [./nixos/pkgs/default.nix]. This is my bug and I do not have time to resolve it.
2. The dotfiles are in `./nixos/pkgs/confs/` directory.
3. Needs a better way to install and/or update.

## How to change and install

1. Clone this repo.
2. Make changes to this repo.
3. Copy `./nixos/*` contents to `/etc/nixos`: `sudo cp -vr nixos/* /etc/nixos/`
4. Run `nixos-rebuild`: `sudo nixos-rebuild switch`

## Manual package installation required

* Zulip chat
* 

## TODO

* Emacs server and client
* Firefox extensions
