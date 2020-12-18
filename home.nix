{ config, pkgs, ... }:

let
  nixos = false; # todo, make this better
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

  programs.man.enable = false;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  programs.git = {
    enable = true;
    userName = "Hunter Jones";
    userEmail = "hjones2199@gmail.com";
  };

  programs.tmux = {
    enable = true;
    shortcut = "'C-\\'";
    terminal = "screen-256color";
    extraConfig = ''
    source "${if nixos then pkgs.powerline else "/usr/share"}/powerline/bindings/tmux/powerline.conf"
    '';
  };

  systemd.user.services = {
    gpsd = user-services.gpsd;
    indisim = user-services.indisim;
    indilive = user-services.indilive;
  };
}
