{stdenv, fetchurl, libcap}:

assert stdenv.isLinux -> libcap != null;
 
stdenv.mkDerivation rec {
  name = "ntp-4.2.6p4";
  
  src = fetchurl {
    url = "http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/${name}.tar.gz";
    sha256 = "1ww1hpy0yfmj13vs46d80hs48hy8ig6kn6p6d8q2syym02khxhyy";
  };
  
  configureFlags = ''
    --without-crypto
    ${if stdenv.isLinux then "--enable-linuxcaps" else ""}
  '';
  
  buildInputs = stdenv.lib.optional stdenv.isLinux libcap;

  meta = {
    homepage = http://www.ntp.org/;
    description = "An implementation of the Network Time Protocol";
  };
}
