{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = inputs: rec {
    user-info = (import ./user-info.nix);
    homeConfigurations = {
      minimal = inputs.home-manager.lib.homeManagerConfiguration rec {
        system = "x86_64-linux";
        homeDirectory = user-info.homeDir;
        username = user-info.unixName;
        configuration.imports = [ ./home.nix ];
        stateVersion = "21.11";
      };
    };
    defaultPackage = homeConfigurations.minimal.activationPackage;
  };
}
