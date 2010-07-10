{stdenv, fetchurl, mesa, libX11, openssl, libXext, libjpeg_turbo}:

stdenv.mkDerivation {
  name = "virtualgl-2.1.4";
  src = fetchurl {
    url = mirror://sourceforge/virtualgl/VirtualGL-2.1.4.tar.gz;
    sha256 = "d455e599620473a07711196615e59c73d08a7f392a9fcf60a6bc05d82809d89d";
  };

  patches = [ ./xshm.patch ];

  preInstall =''
    export makeFlags="prefix=$out"
  '';

  buildInputs = [ mesa libX11 openssl libXext libjpeg_turbo ];

  meta = {
    homepage = http://www.virtualgl.org/;
    description = "X11 GL rendering in a remote computer with full 3D hw acceleration";
    license = "free"; # many parts under different free licenses
  };
}
