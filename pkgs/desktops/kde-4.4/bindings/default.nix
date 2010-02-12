{ stdenv, fetchurl, lib, python, sip, pyqt4, zlib, libpng, freetype, fontconfig, qt4
, libSM, libXrender, libXrandr, libXfixes, libXinerama, libXcursor, libXext, kdelibs}:

# This function will only build the pykde4 module. I don't need the other bindings and
# some bindings are even broken.

stdenv.mkDerivation {
  name = "kdebindings-4.4.0";
  src = fetchurl {
    url = mirror://kde/stable/4.4.0/src/kdebindings-4.4.0.tar.bz2;
    sha256 = "1yn0wynnigbp288j9pqfd5cppc6mja9z9pcfz7g789pmyig42jvd";
  };
  builder = ./builder.sh;
  buildInputs = [ python sip pyqt4 zlib libpng freetype fontconfig qt4
                  libSM libXrender libXrandr libXfixes libXcursor libXinerama libXext kdelibs ];
  meta = {
    description = "KDE bindings";
    longDescription = "Provides KDE bindings for several languages such as Java, Smoke and Python";
    license = "LGPL";
    homepage = http://www.kde.org;
    maintainers = [ lib.maintainers.sander ];
  };
}
