/* Automatically generated by `update-gcc.sh', do not edit.
   For GCC 4.4.6.  */
{ fetchurl, optional, version, langC, langCC, langFortran, langJava, langAda }:

assert version == "4.4.6";
optional /* langC */ true (fetchurl {
  url = "mirror://gcc/releases/gcc-${version}/gcc-core-${version}.tar.bz2";
  sha256 = "c2959820de3e42eee6b1d381586992f26430f0083b9a51db31d706080fc9b44a";
}) ++
optional langCC (fetchurl {
  url = "mirror://gcc/releases/gcc-${version}/gcc-g++-${version}.tar.bz2";
  sha256 = "6d5d2dacab9569472e4caa291abe94017a9b19574b9b0d866de7b04702634ddf";
}) ++
optional langFortran (fetchurl {
  url = "mirror://gcc/releases/gcc-${version}/gcc-fortran-${version}.tar.bz2";
  sha256 = "2b9998716a16b80f4cf843ce81da1cf58ce116e0b85422e3004ce4454e8ff923";
}) ++
optional langJava (fetchurl {
  url = "mirror://gcc/releases/gcc-${version}/gcc-java-${version}.tar.bz2";
  sha256 = "7c8c12eac21d2a5c605ea4d9b7aa52e482354205b801bc93d62603b6f0956b35";
}) ++
optional langAda (fetchurl {
  url = "mirror://gcc/releases/gcc-${version}/gcc-ada-${version}.tar.bz2";
  sha256 = "771ef0e90abf61208ce84689bed15391ad249287e36a28e816d6a044035af0c6";
}) ++
[]
