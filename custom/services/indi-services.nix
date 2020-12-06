{ pkgs, ... }:

let
  drivers = [
    "${pkgs.indilib}/bin/indi_simulator_telescope"
    "${pkgs.indilib}/bin/indi_simulator_guide"
  ];
  with-drivers = pkgs.lib.strings.concatStringsSep " ";
in

{
  indisim = {
    Unit = {
      Description = "Starts indi telescope simulators";
    };
    Service = {
      type = "simple";
      ExecStart = "${pkgs.indilib}/bin/indiserver ${with-drivers drivers}";
    };
  };
}
