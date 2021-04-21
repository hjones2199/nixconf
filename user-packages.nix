{ pkgs, ... }:

let
  custom = import ./custom-packages.nix;
in
{
  devPkgs = [
    # Development Packages
    # Compilers
    pkgs.clang_11
    pkgs.llvmPackages.bintools
    pkgs.rustup
    # Debuggers
    pkgs.gdb
    pkgs.lldb
    pkgs.valgrind
    # Interpreters
    pkgs.python3
    pkgs.racket
    pkgs.clojure
    pkgs.nodejs
    pkgs.octaveFull
    # Build Systems
    pkgs.meson
    pkgs.ninja
    pkgs.cmake
    # Version Control
    pkgs.subversion
    # Misc
    pkgs.websocat
    pkgs.glade
    pkgs.clang-analyzer
    pkgs.clang-tools
    pkgs.rust-analyzer
    pkgs.clojure-lsp
    pkgs.leiningen
    pkgs.universal-ctags
  ];

  desktopPkgs = [
    # Desktop Packages
    # Chat
    pkgs.mumble
    pkgs.teams
    pkgs.slack
    pkgs.element-desktop
    pkgs.discord
    # pkgs.zoom-us
    pkgs.spotify
    # Multimedia
    pkgs.vlc
    pkgs.gimp
    pkgs.krita
    pkgs.pinta
    pkgs.darktable
    # Theme
    pkgs.breeze-icons
    pkgs.papirus-icon-theme
    pkgs.capitaine-cursors
    # Games
    pkgs.steam
    pkgs.steam-run
    pkgs.multimc
    # Misc
    pkgs.wireshark
    pkgs.vscodium
    # pkgs.vscode
    pkgs.virt-manager
    pkgs.remmina
    pkgs.bitwarden
    pkgs.etcher
    pkgs.evolution
    pkgs.protonmail-bridge
  ];

  astroPkgs = [
    # Astronomy Packages
    pkgs.gpsd
    pkgs.indi-full
    pkgs.siril
    pkgs.phd2
    pkgs.kstars
    pkgs.stellarium
  ];

  termPkgs = [
    # Terminal Tools
    pkgs.zip
    pkgs.unzip
    pkgs.gnupg
    pkgs.zile
    pkgs.htop
    pkgs.neofetch
    pkgs.w3m
    pkgs.whois
    pkgs.traceroute
    pkgs.nettools
    pkgs.speedtest-cli
    pkgs.bat
    pkgs.exa
    pkgs.ripgrep
    pkgs.tokei
    pkgs.tealdeer
    pkgs.du-dust
    pkgs.fd
    pkgs.sd
    pkgs.sshfs
    pkgs.nixopsUnstable
  ];
}
