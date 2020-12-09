{ pkgs, ... }:

let
  indi-services = (import ./custom/services/indi-services.nix) { pkgs = pkgs; };
in
{
  gpsd = {
    Unit = {
      Description = "Starts GPSD daemon on /dev/ttyACM0";
    };
    Service = {
      type = "simple";
      ExecStart = "/home/hdjones/.nix-profile/bin/gpsd -N /dev/ttyACM0";
    };
  };
  indisim = indi-services.indisim;
}
