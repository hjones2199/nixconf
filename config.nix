let custom = import ./custom-packages.nix; in rec {
  allowUnfree = true;

  devPkgs = pkgs: with pkgs; [
    # Development Packages
    racket
    sbcl
    rustup
    clang-tools
    lldb
    valgrind
    universal-ctags
    meson
    ninja
    subversion
    nodejs
  ];

  desktopPkgs = pkgs: with pkgs; [
    # Desktop Packages
    custom.nixGL
    breeze-icons
	  emacs
    vscodium
    bitwarden
    etcher
    mumble
    element-desktop
    discord
    darktable
    torbrowser
  ];

  astroPkgs = pkgs: with pkgs; [
    # Astronomy Packages
    custom.phd2
    custom.siril
    custom.entangle
    indilib
    custom.indi-3rdparty
    kstars
  ];

  termPkgs = pkgs: with pkgs; [
    # Terminal Tools
    htop
    neofetch
    postgresql_12
    w3m
    tmux
    whois
    traceroute
    nettools
    speedtest-cli
    powershell
    bat
    exa
    ripgrep
    tokei
    tealdeer
    du-dust
    fd
    sd    
  ];

  packageOverrides = pkgs: with pkgs; {
    userPackages = pkgs.buildEnv {
      name = "user-packages";
      paths = devPkgs pkgs ++
              desktopPkgs pkgs ++
              astroPkgs pkgs ++
              termPkgs pkgs;
      pathsToLink = [
        "/bin"
        "/share/man"
        "/share/doc"
        "/share/applications"
        "/share/icons"
        "/share/pixmaps"
        "/share/indi"
      ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
