{stdenv, fetchurl}:

derivation {
  name = "gzip-1.3.3";
  system = stdenv.system;
  builder = ./builder.sh;
  src = fetchurl {
    url = http://www.gzip.org/gzip-1.3.3.tar.gz;
    md5 = "52eaf713673507d21f7abefee98ba662";
  };
  inherit stdenv;
}
