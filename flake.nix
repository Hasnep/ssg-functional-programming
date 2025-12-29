{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      perSystem =
        { self', pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            packages = [
              # keep-sorted start
              pkgs.deadnix
              pkgs.keep-sorted
              pkgs.nixfmt
              pkgs.nodePackages.prettier
              pkgs.pandoc
              pkgs.pre-commit
              pkgs.python3Packages.pre-commit-hooks
              pkgs.rumdl
              pkgs.taplo
              pkgs.typos
              # keep-sorted end
            ];
            shellHook = "pre-commit install --overwrite";
          };
          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
