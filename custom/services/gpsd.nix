{ prefix, device, ... }:

{
  Unit = {
    Description = "Starts GPS daemon on ${device}";
  };
  Service = {
    type = "simple";
    ExecStart = "${prefix}/bin/gpsd -N ${device}";
  };
}
