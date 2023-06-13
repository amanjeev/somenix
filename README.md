# NixOS Configs using Flakes

## How to change and install
1. Clone this repo
2. For a new machine
    - add new platform in directory under `./platform/<machine>`
    - make appropriate changes from `configuration.nix` and `hadrware-configuration.nix`
    - add the machine to `flake.nix`
3. Run the `nixos-rebuild`: `sudo nixos-rebuild switch --install-bootloader --flake .#<machine>`
4. Move `./confs` files to their appropriate locations

## Update (not upgrade)

1. `cd ~/somenix`
2. `sudo nix flake update`
3. `sudo nixos-rebuild switch --flake .#machine-name`

## List generations

1. `cd ~/somenix`
2. `sudo nix-env -p /nix/var/nix/profiles/system --list-generations`

## Add a new package

1. Create a new file in [packages](./packages/) directory.
2. Add various contents that your heart pleases. This is necessary because your heart will bleed debugging it.
3. Pray.
4. Add the call in [flake.nix](./flake.nix).
## Debugging

### Build locally while developing

1. Use command `ix-build -E 'with import <nixpkgs> { }; callPackage ./packages/yourpackage.nix {}' --show-trace`
2. Run `result/bin/yourpackage` if it builds fine

### The SHA256 stuff

You may need various SHAs. You will need to try many many things. As an example, look at [nrfdfu.nix](./packages/nrfdfu.nix). It has two SHAs, one for `fetchFromGitHub` and other for `rustPlatform.buildRustPackage`.

#### Pushing all 0s.

```
> ERROR: cargoSha256 is out of date
>
> Cargo.lock is not the same in /build/nrfdfu-rs-v0.1.3-vendor.tar.gz
>
> To fix the issue:
> 1. Use "0000000000000000000000000000000000000000000000000000" as the cargoSha256 value
> 2. Build the derivation and wait for it to fail with a hash mismatch
> 3. Copy the 'got: sha256:' value back into the cargoSha256 field
>
```

#### Changing cargoHash to others

Like using `carghoHash` to `cargoSha256` will give you better logs

#### SHA from URL fetching 

```
nix-prefetch-url --unpack --type sha256  https://github.com/user/mypackage/archive/vx.y.z.tar.gz
```

#### SRI format

You may need to convert the SHA256 into SRI format using this command

```
nix hash to-sri --type sha256  0784xz1svjfzsvcd0ghyrjqragvrasll674fn96hg660bv0df5gc
```

## Gratitude

- [Spacekookie](https://twitter.com/spacekookie) for introducing me and giving me my first NixOS config to copy
- [Ana, Hoverbear](https://twitter.com/a_hoverbear) for showing me the light of Nix Flakes and giving me the setup to copy
- [Graham](https://twitter.com/grhmc/) on being in the NixOS community and constantly improving it
- NixOS folks who constantly improve things
- Friends of this land who help me out when I have questions