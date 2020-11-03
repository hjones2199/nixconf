{ stdenv,
  fetchgit,
  pkg-config,
  meson,
  ninja,
  cmake,
  git,
  gtk3,
  wrapGAppsHook,
  fftwFloat,
  cfitsio,
  gsl,
  exiv2,
  opencv,
  libconfig,
  libraw,
  libtiff,
  libpng,
  libjpeg,
  ffmpeg,
  gnuplot,
  curl
}:


stdenv.mkDerivation rec {
  pname = "siril";
  version = "0.99.6";

  src = fetchgit {
    url = "https://gitlab.com/free-astro/${pname}";
    rev = "refs/tags/${version}";
    sha256 = "0prfj6lkzn959gz649hl1kbzpkn509zk3c2x6lrp6kpdssgb3nzy";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ meson ninja git pkg-config cmake ];
  buildInputs = [
    gtk3
    wrapGAppsHook
    fftwFloat
    cfitsio
    gsl
    exiv2
    opencv
    libconfig
    libraw
    libtiff
    libpng
    libjpeg
    ffmpeg
    gnuplot
    curl
  ];

  enableParallelBuilding = true;

  mesonFlags = [
    "--buildtype release"
  ];

  dontUseMesonConfigure = true;
  dontUseCmakeConfigure = true;

  # necessary because project uses default build dir for flatpaks/snaps
  configureScript =
    ''
    meson --buildtype release nixbld .
    '';

  postConfigure = "cd nixbld";

  meta = with stdenv.lib; {
    homepage = "https://www.siril.org/";
    description = "An astronomical image processing tool";
    license = licenses.gpl3;
    maintainers = with maintainers; [ hjones2199 ];
    platforms = [ "x86_64-linux" ];
  };
}
