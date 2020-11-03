with import <nixpkgs> {};

{
  phd2 = callPackage ./custom/phd2.nix { };
  siril = callPackage ./custom/siril.nix { };
}
