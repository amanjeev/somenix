#!/bin/sh

set -eo pipefail

DIR=$(realpath $(dirname $0))
ROOT="$DIR/nixos/roots/$1/configuration.nix"  # first argument is root name

export NIXOS_CONFIG="$ROOT"  # set the root

echo NixOS Config is: $NIXOS_CONFIG
echo Running: nixos-rebuild "${@:2}"

nixos-rebuild "${@:2}"

