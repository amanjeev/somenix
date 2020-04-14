#!/bin/sh

set -eo pipefail

DIR=$(realpath $(dirname $0))
ROOT="$DIR/nixos/roots/$1/configuration.nix"  # root name

export NIXOS_CONFIG="$ROOT"  # set the root

echo NixOS Config is: $NIXOS_CONFIG
echo Running: "${@:2}"

$2 \
-I "nixpkgs-overlays=$DIR/nixos/overlays" \
-I "nixos-config=$ROOT" \
"${@:3}"

