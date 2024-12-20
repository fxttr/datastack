{
  description = "Next-gen Datastack";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.k9s
            pkgs.nano
            pkgs.sops
            pkgs.kubectl
            pkgs.kubernetes-helm
            pkgs.fluxcd
          ];
        };
      });
}
