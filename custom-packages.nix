with import <nixpkgs> {};

let nixGLRepo = fetchFromGitHub {
      owner = "guibou";
      repo = "nixGL";
      rev = "7d6bc1b21316bab6cf4a6520c2639a11c25a220e";
      sha256 = "02y38zmdplk7a9ihsxvnrzhhv7324mmf5g8hmxqizaid5k5ydpr3";
    };
    nixGLFile = import nixGLRepo { };
in
{
#  phd2 = callPackage ./custom/phd2.nix { };
  siril = callPackage ./custom/siril.nix { };
#  entangle = callPackage ./custom/entangle.nix { };
  astrophoto = libsForQt5.callPackage ./custom/astrophoto-desktop.nix { };
  indi-3rdparty = callPackage ./custom/indi-3rdparty.nix { };
  nixGL = nixGLFile.nixGLIntel;
}
