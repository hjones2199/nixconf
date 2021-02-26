{ config, pkgs, ... }:

let
  user-info = (import ./user-info.nix);
  user-packages = (import ./user-packages.nix) { pkgs = pkgs; };
  user-services = (import ./user-services.nix) { pkgs = pkgs; };
in rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = rec {
    username = user-info.unixName;
    homeDirectory = "/home/${username}";
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

  programs.zsh = {
    enable = true;
    sessionVariables = {
      EDITOR = "emacs";
    };
    # initExtra = ''
    #   eval `dircolors $HOME/.config/LS_COLORS`
    # '';
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  programs.git = {
    enable = true;
    userName = user-info.fullName;
    userEmail = user-info.userEmail;
  };

  programs.tmux = {
    enable = true;
    shortcut = "'C-\\'";
    terminal = "screen-256color";
    extraConfig = ''
    source "${pkgs.powerline}/share/tmux/powerline.conf"
    '';
  };

  systemd.user.services = {
    gpsd = user-services.gpsd;
    indisim = user-services.indisim;
    indilive = user-services.indilive;
  };
}
