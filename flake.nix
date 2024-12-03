{
  description = "Next-gen Datastack";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system: let 
      pkgs = import nixpkgs { inherit system; }; 
    in 
    {
      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.k9s
          pkgs.opentofu
          pkgs.python3
          pkgs.python3Packages.virtualenv
        ];

        shellHook = ''
          if [ ! -d .venv ]; then
            echo "Creating virtual environment in .venv"
            python -m venv .venv
          fi

          echo "Activating virtual environment"
          source .venv/bin/activate

          echo "You are now in the Python3 development environment with .venv"
        '';
      };
    });
}
