{ config, pkgs, ... }:

let
  user-info = (import ./user-info.nix);
in
rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = rec {
    extraOutputsToInstall = [ "man" "doc" ];
    packages = [
      pkgs.nix
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.man.enable = false;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
    sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
      QT_STYLE_OVERRIDE = "Adwaita-Dark";
    };
  };

  # programs.emacs = {
  #   enable = true;
  #   extraPackages = epkgs: [ epkgs.vterm ];
  # };

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
    nix-direnv.enable = true;
  };

}
