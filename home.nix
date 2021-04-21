{ config, pkgs, ... }:

let
  user-info = (import ./user-info.nix);
  user-packages = (import ./user-packages.nix) { pkgs = pkgs; };
  user-services = (import ./user-services.nix) {
    pkgs = pkgs;
    homeDir = user-info.homeDir;
  };
in
rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = rec {
    username = user-info.unixName;
    homeDirectory = user-info.homeDir;
    stateVersion = "21.05";
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
      VISUAL = "emacs";
    };
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = user-info.fullName;
    userEmail = user-info.userEmail;
    extraConfig = {
      credential = {
        helper = "${pkgs.gitFull}/share/git/contrib/credential/libsecret/git-credential-libsecret";
      };
    };
  };

  programs.tmux = {
    enable = true;
    shortcut = "'C-\\'";
    terminal = "screen-256color";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.yank;
        extraConfig = ''
          set -g @tmux_power_theme 'forest'
          set -g @tmux_power_time_icon ' '
        '';
      }
      tmuxPlugins.power-theme
    ];
  };

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };

  systemd.user.services = {
    gpsd = user-services.gpsd;
    indisim = user-services.indisim;
    indilive = user-services.indilive;
    protonbridge = user-services.protonbridge;
  };
}
