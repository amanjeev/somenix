# NixOS and Home Manager configs

## Caveats

1. The dotfiles are in `./nixos/pkgs/confs/` directory.

## How to change and install

1. Clone this repo.
2. For a new machine, add a directory under `./nixos/roots/<machine>` and add the `configuration.nix` and `hardware-configuration.nix` under that.
3. Run the `nixos-rebuild` via the `build.sh` wrapper: `sudo ./build.sh <machine> <command>` where `<command>` can be any `nixos-rebuild` subcommand.

## Manual package installation required

* Zulip chat
* 

## TODO

* Emacs server
* Firefox extensions/addons
* VSCode extensions
