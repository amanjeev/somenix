{
    description = "AJ's Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    };

    outputs = { self, nixpkgs }:
        let
            supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
            forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
        in
        {
            overlays.default = final: prev: {
                vscodeConfigured = final.callPackage ./packages/vscode.nix { };
                fishConfigured = final.callPackage ./packages/fish/config.nix { };
            };

            packages = forAllSystems
                (system:
                    let
                        pkgs = import nixpkgs {
                            inherit system;
                            overlays = [ self.overlays.default ];
                            config.allowUnfree = true;
                        };
                    in
                    {
                        inherit (pkgs) fishConfigured vscodeConfigured;
                    });

            devShells = forAllSystems
                (system:
                    let
                        pkgs = import nixpkgs {
                            inherit system;
                            overlays = [ self.overlays.default ];
                        };
                    in
                    {
                        default = pkgs.mkShell
                        {
                            inputsFrom = with pkgs; [ ];
                            buildInputs = with pkgs; [
                                nixpkgs-fmt
                            ];
                        };
                    });

            nixosConfigurations = 
                let
                    wolfhowlBase = {
                        system = "x86_64-linux";
                        modules = with self.nixosModules; [
                            trait.overlay
                            trait.base
                            trait.hardened
                            trait.machine
                            trait.tools
                            user.aj
                        ];
                    };
                    ironyBase = {
                        system = "x86_64-linux";
                        modules = with self.nixosModules; [
                            trait.overlay
                            trait.base
                            trait.hardened
                            trait.machine
                            trait.tools
                            user.aj
                        ];
                    };
                in
                with self.nixosModules; {
                    wolfhowl = nixpkgs.lib.nixosSystem {
                        inherit (wolfhowlBase) system;
                        modules = wolfhowlBase.modules ++ [
                            platform.wolfhowl
                            trait.workstation
                        ];
                    };
                    irony = nixpkgs.lib.nixosSystem {
                        inherit (ironyBase) system;
                        modules = ironyBase.modules ++ [
                            platform.irony
                            trait.workstation
                        ];
                    };
                };

            nixosModules = {
                platform.wolfhowl = ./platform/wolfhowl.nix;
                platform.irony = ./platform/irony.nix;
                trait.overlay = { nixpkgs.overlays = [ self.overlays.default ]; };
                trait.base = ./trait/base.nix;
                trait.machine = ./trait/machine.nix;
                trait.tools = ./trait/tools.nix;
                trait.jetbrains = ./trait/jetbrains.nix;
                trait.hardened = ./trait/hardened.nix;
                trait.sourceBuild = ./trait/source-build.nix;
                # This trait is unfriendly to being bundled with platform-iso
                trait.workstation = ./trait/workstation.nix;
                user.aj = ./user/aj.nix;
            };

            checks = forAllSystems (system: 
                let
                    pkgs = import nixpkgs {
                        inherit system;
                        overlays = [ self.overlays.default ];
                    };
                in
                {
                    format = pkgs.runCommand "check-format"
                    {
                        buildInputs = with pkgs; [ rustfmt cargo ];
                    }   ''
                    ${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt --check ${./.}
                    touch $out # it worked!
                '';
                });
        };
}