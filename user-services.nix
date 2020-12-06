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
      type = "forking";
      ExecStart = "${pkgs.gpsd}/bin/gpsd /dev/ttyACM0";
    };
  };
  indisim = indi-services.indisim;
}
