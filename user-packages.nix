{ pkgs, ... }:

let
  custom = import ./custom-packages.nix;
in
{
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
    pkgs.spotify
    pkgs.darktable
  ];

  astroPkgs = [
    # Astronomy Packages
    pkgs.gpsd
    pkgs.indilib
    pkgs.siril
    pkgs.phd2
    pkgs.kstars
    custom.indi-3rdparty
  ];

  termPkgs = [
    # Terminal Tools
    pkgs.zile
    pkgs.htop
    pkgs.neofetch
    pkgs.postgresql_12
    pkgs.w3m
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
}
