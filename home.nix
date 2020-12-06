{ config, pkgs, ... }:

let
  user-packages = (import ./user-packages.nix) { pkgs = pkgs; };
  user-services = (import ./user-services.nix) { pkgs = pkgs; };
in rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "hdjones";
    homeDirectory = "/home/hdjones";
    stateVersion = "21.03";
    extraOutputsToInstall = [ "man" "doc" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages =
    user-packages.devPkgs
    ++ user-packages.termPkgs
    ++ user-packages.desktopPkgs
    ++ user-packages.astroPkgs;

  programs.emacs.enable = true;
  programs.man.enable = false;

  programs.git = {
    enable = true;
    userName = "Hunter Jones";
    userEmail = "hjones2199@gmail.com";
  };

  systemd.user.services = {
    gpsd = user-services.gpsd;
    indisim = user-services.indisim;
  };
}
