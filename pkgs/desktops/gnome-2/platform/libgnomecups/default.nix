{stdenv, fetchurl, pkgconfig, gtk, gettext, libxml2, intltool, libart_lgpl }:

let
  name = "libgnomecups-0.2.3";
in
stdenv.mkDerivation {
  inherit name;

  src = fetchurl {
    url = "mirror://gnome/sources/libgnomecups/0.2/${name}.tar.bz2";
    sha256 = "0a8xdaxzz2wc0n1fjcav65093gixzyac3948l8cxx1mk884yhc71";
  };

  buildInputs = [ pkgconfig gtk gettext intltool libart_lgpl ];
  propagatedBuildInputs = [ libxml2 ];
}
