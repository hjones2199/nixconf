{ config, pkgs, ... }:

let
  custom = import ./custom-packages.nix;

  devPkgs = [
    # Development Packages
    pkgs.racket
    pkgs.sbcl
    pkgs.rustup
    pkgs.clang-tools
    pkgs.lldb
    pkgs.valgrind
    pkgs.universal-ctags
    pkgs.meson
    pkgs.ninja
    pkgs.cmake
    pkgs.subversion
    pkgs.nodejs
  ];

  desktopPkgs = [
    # Desktop Packages
    custom.nixGL
    pkgs.breeze-icons
    pkgs.vscodium
    pkgs.bitwarden
    pkgs.etcher
    pkgs.mumble
    pkgs.slack
    pkgs.element-desktop
    pkgs.discord
    pkgs.darktable
    pkgs.torbrowser
  ];

  astroPkgs = [
    # Astronomy Packages
    pkgs.gpsd
    pkgs.indilib
    custom.indi-3rdparty
    pkgs.phd2
    pkgs.kstars
    custom.siril
  ];

  termPkgs = [
    # Terminal Tools
    pkgs.zile
    pkgs.htop
    pkgs.neofetch
    pkgs.postgresql_12
    pkgs.w3m
    pkgs.tmux
    pkgs.whois
    pkgs.traceroute
    pkgs.nettools
    pkgs.speedtest-cli
    pkgs.powershell
    pkgs.bat
    pkgs.exa
    pkgs.ripgrep
    pkgs.tokei
    pkgs.tealdeer
    pkgs.du-dust
    pkgs.fd
    pkgs.sd
  ];

in rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "hdjones";
    homeDirectory = "/home/hdjones";
    stateVersion = "21.03";
    extraOutputsToInstall = [ "man" "doc" ];
  };

  home.packages =
    devPkgs
    ++ termPkgs
    ++ desktopPkgs
    ++ astroPkgs;

  programs.emacs.enable = true;
  programs.man.enable = false;
  
}
