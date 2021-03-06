{ pkgs, homeDir, ... }:

let
  user-profile = "${homeDir}/.nix-profile";
  indi-service = import ./custom/services/indiserver.nix;
  gpsd-service = import ./custom/services/gpsd.nix;
  protonmail-service = import ./custom/services/protonmail-bridge.nix;
in
{
  gpsd = gpsd-service {
    prefix = user-profile;
    device = "/dev/ttyACM0";
  };
  indisim = indi-service {
    pkgs = pkgs;
    prefix = user-profile;
    drivers = [
      "indi_simulator_telescope"
      "indi_simulator_guide"
    ];
  };
  indilive = indi-service {
    pkgs = pkgs;
    prefix = user-profile;
    drivers = [
      "indi_eqmod_telescope"
      "indi_canon_ccd"
      "indi_gpsd"
    ];
  };
  protonbridge = protonmail-service {
    prefix = user-profile;
  };
}
