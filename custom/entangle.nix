{ stdenv,
  fetchFromGitLab,
  meson,
  ninja,
  cmake,
  pkg-config,
  python3,
  gst_all_1,
  glib,
  gdk-pixbuf,
  gtk3,
  gtk-doc,
  libgphoto2,
  libgudev,
  gobject-introspection,
  lcms2,
  libpeas,
  gexiv2,
  libraw,
  perl,
  wrapGAppsHook,
  libxslt,
  docbook5,
  docbook_xsl,
  docbook_xsl_ns
}:

stdenv.mkDerivation rec {
  pname = "entangle";
  version = "3.0";

  src = fetchFromGitLab {
    owner = "entangle";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "1pdmgxjdb3xlcqsaz7l8qzj5f7g7nwzhsrgid8929bm36d49cgc7";
  };

  nativeBuildInputs = [
    meson
    ninja
    cmake
    pkg-config
    wrapGAppsHook
    perl
    python3
    libxslt
    docbook5
    docbook_xsl
    docbook_xsl_ns
  ];

  buildInputs = [
    gst_all_1.gstreamer
    gst_all_1.gst-editing-services
    gtk-doc
    gtk3
    glib
    gdk-pixbuf
    gtk3
    libgphoto2
    libgudev
    gobject-introspection
    lcms2
    libpeas
    gexiv2
    libraw
  ];

  enableParallelBuilding = true;
  mesonWrapMode = "default";

  mesonFlags = [
    "--buildtype release"
    "-Denable-gtk-doc=false"
    "-Dc_args=-I${glib.dev}/include/gio-unix-2.0"
  ];

  meta = with stdenv.lib; {
    homepage = "https://entangle-photo.org/";
    description = "A graphical interface for tethered shooting";
    license = licenses.gpl3;
    maintainers = with maintainers; [ hjones2199 ];
    platforms = [ "x86_64-linux" ];
  };
}
