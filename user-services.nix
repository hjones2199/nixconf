{ pkgs, homeDir, ... }:

let
  user-profile = "${homeDir}/.nix-profile";
in {
  gpg-smartcard = {
    Unit = {
      Description = "Starts GPS daemon on ${device}";
    };
    Service = {
      type = "simple";
      ExecStart = "${prefix}/bin/gpsd -N ${device}";
    };
  };
}
