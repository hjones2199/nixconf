{ stdenv, lib, fetchgit, pkgconfig, cmake, wrapQtAppsHook,
  qtwebengine, curl, indilib, libnova }:

stdenv.mkDerivation rec {
  pname = "astrophoto";
  version = "0.1.0_20200610-1d48590";

  src = fetchgit {
    url = "https://github.com/GuLinux/AstroPhoto-Plus-Desktop";
    rev = "refs/tags/v${version}";
    sha256 = "00xn38hzbyb3vw7272x10wwnn1gghg1fy8sq4av30zirhihixis8";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake pkgconfig wrapQtAppsHook ];
  buildInputs = [ qtwebengine curl indilib libnova ];

  # cmakeFlags = [
  #   "-DOPENSOURCE_ONLY=1"
  # ];

  patches = [
    ./astrophoto-fix.patch
  ];

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://astrophotoplus.gulinux.net/";
    description = "A lightweight sequence generator and INDI client";
    license = licenses.gpl3;
    maintainers = with maintainers; [ hjones2199 ];
    platforms = [ "x86_64-linux" ];
  };
}
