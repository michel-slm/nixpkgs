{stdenv, fetchurl, apacheAnt, javaCup}:

stdenv.mkDerivation {
  name = "jasmin-dev-20060422015512";
  builder = ./builder.sh;

  src = fetchurl {
    url = http://nix.cs.uu.nl/dist/tarballs/jasmin-dev-20060422015512.tar.gz;
    md5 = "0e49e532b4658c959582c5d5b5e28bf1";
  };

  inherit javaCup;
  buildInputs = [apacheAnt];
}
