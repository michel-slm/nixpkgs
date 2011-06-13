{ fetchurl, stdenv, libtool, ncurses }:

stdenv.mkDerivation rec {
  name = "global-5.9.6";

  src = fetchurl {
    url = "mirror://gnu/global/${name}.tar.gz";
    sha256 = "1hs6dspwl3pnh03blwnhlbm9lm16afm7z8f8sbvim19d7ylm7zkb";
  };

  buildInputs = [ libtool ncurses ];

  configurePhase =
    '' ./configure --prefix="$out" --disable-static ''
    + ''--with-posix-sort=$(type -p sort) ''
    + ''--with-ltdl-include=${libtool}/include --with-ltdl-lib=${libtool}/lib ''
    + ''--with-ncurses=${ncurses}'';

  doCheck = true;

  postInstall = ''
    ensureDir "$out/share/emacs/site-lisp"
    cp -v *.el "$out/share/emacs/site-lisp"
  '';

  meta = {
    description = "GNU GLOBAL source code tag system";

    longDescription = ''
      GNU GLOBAL is a source code tagging system that works the same way
      across diverse environments (Emacs, vi, less, Bash, web browser, etc).
      You can locate specified objects in source files and move there easily.
      It is useful for hacking a large project containing many
      subdirectories, many #ifdef and many main() functions.  It is similar
      to ctags or etags but is different from them at the point of
      independence of any editor.  It runs on a UNIX (POSIX) compatible
      operating system like GNU and BSD.
    '';

    license = "GPLv3+";

    homepage = http://www.gnu.org/software/global/;

    maintainers = [ stdenv.lib.maintainers.ludo ];
    platforms = stdenv.lib.platforms.gnu;  # arbitrary choice
  };
}
