{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        user-info = (import ./user-info.nix);
        state-version = "21.11";
      in
        rec {
        packages = {
          config = inputs.home-manager.lib.homeManagerConfiguration rec {
            modules = [
              ./home.nix
              {
                home = {
                  homeDirectory = user-info.homeDir;
                  username = user-info.unixName;
                  stateVersion = state-version;
                };
              }
            ];
            inherit pkgs;
          };
        };
        defaultPackage = packages.config.activationPackage;
      }
    );
}
