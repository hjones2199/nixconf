{ pkgs, prefix, drivers, ... }:

let
  with-drivers = pkgs.lib.strings.concatStringsSep " ";
in
{
  Unit = {
    Description = "Starts indi telescope drivers";
  };
  Service = {
    type = "simple";
    Environment = [
      "INDIPREFIX=${prefix}"
    ];
    ExecStart = "${prefix}/bin/indiserver ${with-drivers drivers}";
  };
}
