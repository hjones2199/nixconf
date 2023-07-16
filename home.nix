{ config, pkgs, ... }:

let
  user-info = (import ./user-info.nix);
  user-services = (import ./user-services.nix) {
    pkgs = pkgs;
    homeDir = user-info.home-dir;
  };
in
rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = rec {
    extraOutputsToInstall = [ "man" "doc" ];
    packages = [
      pkgs.nixUnstable
      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.argo
      pkgs.argocd
      pkgs.vault
      pkgs.terraform
      pkgs.racket
      pkgs.google-cloud-sdk
      pkgs.mozwire
      pkgs.go
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.man.enable = false;

  programs.zsh = rec {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "sudo" "git" "systemd" "firewalld" "dnf"
        "gcloud" "aws"
        "ansible" "kubectl" "helm" "oc" "vault"
        "rust" "golang"
        "emacs" "ripgrep"
      ];
    };
    enableCompletion = true;
    dotDir = ".config/zsh";
    sessionVariables = rec {
      EDITOR = "emacs";
      VISUAL = EDITOR;
      QT_STYLE_OVERRIDE = "Adwaita-Dark";
    };
    profileExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh;
      fi
      if [ -e $HOME/${dotDir}/.zlocal ]; then
        source $HOME/${dotDir}/.zlocal;
      fi
    '';
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

  systemd.user.services = {
    # gpg-smartcard = user-services.gpg-smartcard;
  };
}
