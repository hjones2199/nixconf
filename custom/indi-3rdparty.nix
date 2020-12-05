{ stdenv
, fetchFromGitHub
, cmake
, cfitsio
, libusb1
, zlib
, boost
, libnova
, curl
, libjpeg
, gsl
, fftw
, indilib
, libgphoto2
, libraw
, libftdi1
, libdc1394
, gpsd
, ffmpeg
}:

stdenv.mkDerivation rec {
  pname = "indi-3rdparty";
  version = "1.8.6";

  src = fetchFromGitHub {
    owner = "indilib";
    repo = "indi-3rdparty";
    rev = "v${version}";
    sha256 = "1mfirpayyx8h8c1xdw3iqqd2agrq7xa78myjvaqyjamb2lcpqfb9";
  };

  cmakeFlags = [
    "-DINDI_DATA_DIR=\${CMAKE_INSTALL_PREFIX}/share/indi"
    "-DUDEVRULES_INSTALL_DIR=\${CMAKE_INSTALL_PREFIX}/lib/udev/rules.d"
    "-DRULES_INSTALL_DIR=\${CMAKE_INSTALL_PREFIX}/lib/udev/rules.d"
    "-DWITH_SX=off"
    "-DWITH_SBIG=off"
    "-DWITH_APOGEE=off"
    "-DWITH_FISHCAMP=off"
    "-DWITH_DSI=off"
    "-DWITH_QHY=off"
    "-DWITH_ARMADILLO=off"
    "-DWITH_PENTAX=off"
  ];

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    curl
    cfitsio
    libusb1
    zlib
    boost
    libnova
    gsl
    gpsd
    libjpeg
    fftw
    indilib
    libgphoto2
    libraw
    libftdi1
    libdc1394
    ffmpeg
  ];

  meta = with stdenv.lib; {
    homepage = "https://www.indilib.org/";
    description = "Third party drivers for the INDI astronomical software suite";
    license = licenses.lgpl2Plus;
    maintainers = with maintainers; [ hjones2199 ];
    platforms = [ "x86_64-linux" ];
  };
}