{ prefix, ... }:

{
  Unit = {
    Description = "Starts protonmail bridge";
  };
  Service = {
    type = "simple";
    ExecStart = "${prefix}/bin/protonmail-bridge";
  };
}
