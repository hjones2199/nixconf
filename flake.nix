{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  let user-info = (import ./user-info.nix);
  outputs = inputs: {
    homeConfigurations = {
      jdoe = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = user-info.homeDir;
        username = user-info.unixName;
        configuration.imports = [ ./home.nix ];
      };
    };
  };
}
