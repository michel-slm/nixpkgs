{ stdenv, fetchurl, cmake, wxGTK, openal, pkgconfig, curl, libtorrentRasterbar
, gettext, bash, gawk, boost}:
stdenv.mkDerivation rec {

  name = "springlobby-${version}";
  version = "0.146";

  src = fetchurl {
    url = "http://www.springlobby.info/tarballs/springlobby-${version}.tar.bz2";
    sha256 = "55899baf6732e48bfaa36d80974aa135c051d2cbb6fe92fbcffd80440639eedf";
  };

  buildInputs = [ cmake wxGTK openal pkgconfig curl gettext libtorrentRasterbar boost];

  prePatch = ''
    substituteInPlace tools/regen_config_header.sh --replace "#!/usr/bin/env bash" "#!${bash}/bin/bash"
    substituteInPlace tools/test-susynclib.awk --replace "#!/usr/bin/awk" "#!${gawk}/bin/awk"
    substituteInPlace CMakeLists.txt --replace "boost_system-mt" "boost_system"
  '';

  # for now sound is disabled as it causes a linker error with alure i can't resolve (qknight)
  cmakeFlags = "-DOPTION_SOUND:BOOL=OFF"; 

  enableParallelBuilding = true;

  #buildPhase = "make VERBOSE=1";

  meta = with stdenv.lib; {
    homepage = http://springlobby.info/;
    description = "A free cross-platform lobby client for the Spring RTS project.";
    license = licenses.gpl2;
    maintainers = [ maintainers.phreedom maintainers.qknight];
    platforms = platforms.linux;
  };
}
