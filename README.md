# NixOS and Home Manager configs

## Caveats

1. The dotfiles are in `./nixos/pkgs/confs/` directory.

## How to change and install

1. Clone this repo.
2. For a new machine, add a directory under `./nixos/roots/<machine>` and add the `configuration.nix` and `hardware-configuration.nix` under that.
3. Add the unstable nix channel 
```$ sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable
$ sudo nix-channel --update unstable
```
4. Run the `nixos-rebuild` via the `build.sh` wrapper: `sudo ./build.sh <machine> <command>` where `<command>` can be any `nixos-rebuild` subcommand.

## Manual package installation required

* 

## TODO

* Emacs server
* Firefox extensions/addons
* VSCode extensions
