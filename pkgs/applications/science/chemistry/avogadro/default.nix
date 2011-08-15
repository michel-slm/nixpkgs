{ stdenv, fetchurl, cmake, qt4, zlib, eigen, openbabel }:

stdenv.mkDerivation rec {
  name = "avogadro-1.0.3";

  src = fetchurl {
    url = "mirror://sourceforge/avogadro/${name}.tar.bz2";
    sha256 = "0s44r78vm7hf4cs13d2qki3gf178gjj1ihph6rs04g6s4figvdpg";
  };

  buildInputs = [ qt4 eigen zlib openbabel ];

  buildNativeInputs = [ cmake ];

  meta = {
    maintainers = [ stdenv.lib.maintainers.urkud ];
    inherit (qt4.meta) platforms;
  };
}
