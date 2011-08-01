{ stdenv
, fetchurl
, unzip
, zip
, procps
, coreutils
, alsaLib
, ant
, freetype
, cups
, which
, jdk
, nettools
, libX11
, libXt
, libXext
, libXrender
, libXtst
, libXi
, cpio
}:

stdenv.mkDerivation rec {
  name = "openjdk-7b127";

  src = fetchurl {
    url = http://www.java.net/download/openjdk/jdk7/promoted/b147/openjdk-7-fcs-src-b147-27_jun_2011.zip;
    sha256 = "1qhwlz9y5qmwmja4qnxg6sn3pgsg1i11fb9j41w8l26acyhk34rs";
  };

  buildInputs = [
    unzip
    procps
    ant
    which
    zip
    cpio
    nettools
    alsaLib
    libX11
    libXt
    libXext
    libXrender
    libXtst
    libXi
  ];

  postUnpack = ''
    sed -i -e "s@/usr/bin/test@${coreutils}/bin/test@" \
      -e "s@/bin/ls@${coreutils}/bin/ls@" \
      openjdk/hotspot/make/linux/makefiles/sa.make 

    sed -i "s@/bin/echo -e@${coreutils}/bin/echo -e@" \
      openjdk/{jdk,corba}/make/common/shared/Defs-utils.gmk

    sed -i "s@<Xrender.h>@<X11/extensions/Xrender.h>@" \
      openjdk/jdk/src/solaris/native/sun/java2d/x11/XRSurfaceData.c
  '';

  patches = [ ./cppflags-include-fix.patch ./printf-fix.patch ];

  makeFlags = [
    "SORT=${coreutils}/bin/sort"
    "ALSA_INCLUDE=${alsaLib}/include/alsa/version.h"
    "FREETYPE_HEADERS_PATH=${freetype}/include"
    "FREETYPE_LIB_PATH=${freetype}/lib"
    "MILESTONE=release"
    "BUILD_NUMBER=127"
    "CUPS_HEADERS_PATH=${cups}/include"
    "USRBIN_PATH="
    "COMPILER_PATH="
    "DEVTOOLS_PATH="
    "UNIXCOMMAND_PATH="
    "BOOTDIR=${jdk}"
    "ALLOW_DOWNLOADS=true"
  ];

  configurePhase = ''
    make $makeFlags sanity
  '';

  installPhase = ''
    ensureDir $out
    cp -av build/*/j2sdk-image/* $out
  '';

  meta = {
    homepage = http://openjdk.java.net/;

    license = "GPLv2";

    description = "The open-source Java Development Kit";

    maintainers = [ stdenv.lib.maintainers.shlevy ];
  };
}
