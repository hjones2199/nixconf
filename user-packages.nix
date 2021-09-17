{ pkgs, ... }:

let
  custom = import ./custom-packages.nix;
  gnu-octave = pkgs.octaveFull.withPackages (f:
    [
      pkgs.octavePackages.symbolic
      pkgs.octavePackages.parallel
    ]);
  gimp-env = pkgs.gimp-with-plugins.override {
    plugins = with pkgs.gimpPlugins; [
      resynthesizer
    ];
  };
in
{
  devPkgs = [
    # Development Packages
    # Compilers
    pkgs.gcc
    # pkgs.llvmPackages.bintools
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
    # Build Systems
    pkgs.meson
    pkgs.ninja
    pkgs.cmake
    # Version Control
    pkgs.subversion
    # Misc
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
    pkgs.gnome.gnome-shell-extensions
    pkgs.mumble
    pkgs.teams
    pkgs.slack
    pkgs.element-desktop
    pkgs.discord
    pkgs.spotify
    # Multimedia
    pkgs.vlc
    gimp-env
    pkgs.krita
    pkgs.pinta
    pkgs.darktable
    # Theme
    pkgs.breeze-icons
    pkgs.papirus-icon-theme
    pkgs.capitaine-cursors
    # Games
    pkgs.steam
    pkgs.steam-run-native
    pkgs.multimc
    # Misc
    pkgs.wireshark
    pkgs.vscodium
    pkgs.virt-manager
    gnu-octave
    pkgs.remmina
    pkgs.bitwarden
    pkgs.etcher
    pkgs.evolution
    pkgs.protonmail-bridge
    custom.dash-to-dock
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
    pkgs.websocat
    pkgs.nixopsUnstable
  ];
}
