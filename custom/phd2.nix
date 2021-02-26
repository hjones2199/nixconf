{ stdenv, lib, fetchFromGitHub, pkgconfig, cmake, gtk3,
  wxGTK30-gtk3, curl, gettext, glib, indilib, libnova }:

stdenv.mkDerivation rec {
  pname = "phd2";
  version = "2.6.9dev1";

  src = fetchFromGitHub {
    owner = "OpenPHDGuiding";
    repo = "phd2";
    rev = "v${version}";
    sha256 = "1ih7m9lilh12xbhmwm9kkicaqy72mi3firl6df7m5x38n2zj3zm4";
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ gtk3 wxGTK30-gtk3 curl gettext glib indilib libnova ];

  cmakeFlags = [
    "-DOPENSOURCE_ONLY=1"
  ];

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://openphdguiding.org/";
    description = "Telescope auto-guidance application";
    license = licenses.bsd3;
    maintainers = with maintainers; [ hjones2199 ];
    platforms = [ "x86_64-linux" ];
  };
}
