{
  description = "StarryNix Infrastructure";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
  };

  outputs =
    { self, flake-parts, ... }@inputs:
    let
      root = ./.;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        { inputs', pkgs, ... }:
        {
          devShells.default =
            let
              mkShell = pkgs.mkShell.override { stdenv = pkgs.stdenvNoCC; };
            in
            mkShell {
              packages = with pkgs; [
                nil
                nixfmt-rfc-style
              ];
            };

          formatter = pkgs.nixfmt-tree;
        };
    };
}
