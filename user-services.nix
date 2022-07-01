{ pkgs, homeDir, ... }:

let
  user-profile = "${homeDir}/.nix-profile";
in {
  gpg-smartcard = {
    Unit = {
      Description = "Starts gpg smartcard daemon";
    };
    Service = {
      type = "simple";
      ExecStart = "gnupg-pkcs11-scd --daemon";
    };
  };
}
