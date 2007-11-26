let {

  allPackages = import ./all-packages.nix;

  i686LinuxPkgs = {inherit (allPackages {system = "i686-linux";})
    MPlayer
    MPlayerPlugin
    alsaUtils
    apacheAnt
    apacheHttpd
    aspectj
    aspell
    aspellDicts
    aterm
    autoconf
    automake19x
    bash
    bashInteractive
    batik
    binutils
    bison23
    bittorrent
    bmp
    bmp_plugin_musepack
    bmp_plugin_wma
    bsdiff
    bzip2
    cabextract
    cdrkit
    chatzilla
    cksfv
    compiz
    coreutils
    cpio
    cron
    cups
    darcs
    db4
    dhcp
    dietlibc
    diffutils
    docbook5
    docbook5_xsl
    docbook_xml_dtd_42
    docbook_xml_dtd_43
    docbook_xsl
    e2fsprogs
    ecj
    eclipsesdk
    emacs
    emacsUnicode
    enscript
    exult
    feh
    file
    findutils
    firefoxWrapper
    flex2533
    gawk
    gcc
    gcc34
    gcc42
    gdb
    ghc
    ghostscript
    gimp
    gnugrep
    gnum4
    gnumake
    gnupatch
    gnused
    gnutar
    gqview
    graphviz
    grub
    gzip
    hal
    hello
    iana_etc
    iputils
    irssi
    jakartaregexp
    jdkPlugin
    jetty
    jikes
    jing_tools
    jrePlugin
    jwhois
    kbd
    kcachegrind
    kdebase
    keen4
    kernel
    klibc
    ktorrent
    less
    lhs2tex
    libtool
    libxml2
    libxslt
    lvm2
    lynx
    man
    mdadm
    mesa
    mingetty
    mk
    mktemp
    mod_python
    module_init_tools
    mono
    mysql
    #mythtv
    nano
    netcat
    nix
    nixUnstable
    nss_ldap
    ntp    
    nxml
    openoffice
    openssh
    openssl
    pam_console
    pam_ldap
    pam_login
    pam_unix2
    pan
    par2cmdline
    pciutils
    perl
    php
    pidgin
    pkgconfig
    postgresql
    postgresql_jdbc
    procps
    pwdutils
    python
    qt3
    quake3demo
    readline
    reiserfsprogs
    rogue
    rsync
    ruby
    screen
    sdf
    slim
    spidermonkey
    splashutils
    ssmtp
    strace
    strategoxt
    strategoxtUtils
    su
    subversion
    sudo
    swig
    sylpheed 
    sysklogd
    syslinux
    sysvinit
    sysvtools
    tetex
    texinfo
    thunderbird
    tightvnc
    time
    udev
    uml
    unzip
    upstart
    utillinux
    valgrind
    vim
    vlc
    w3m
    wget
    wine
    wirelesstools
    wxHaskell
    x11_ssh_askpass
    xchm
    xfig
    xineUI
    xkeyboard_config
    xmltv
    xmms
    xorg_sys_opengl
    xsel
    xterm
    zdelta
    zip
    ;
  inherit ((allPackages {system = "i686-linux";}).xorg)
    fontbh100dpi
    fontbhlucidatypewriter100dpi
    fontbhttf
    fontcursormisc
    fontmiscmisc
    iceauth
    setxkbmap
    xauth
    xf86inputkeyboard
    xf86inputmouse
    xf86videoi810
    xf86videovesa
    xkbcomp
    xorgserver
    xrandr
    xrdb
    xset
    ;
  inherit ((allPackages {system = "i686-linux";}).gnome)
    gconfeditor
    gnomepanel
    gnometerminal
    gnomeutils
    metacity
    ;
  };

  x86_64LinuxPkgs = {inherit (allPackages {system = "x86_64-linux";})
    aterm242fixes
    autoconf
    automake19x
    bash
    binutils
    bison23
    gcc
    hello
    kernel
    libtool
    nixUnstable
    subversion
    ;    
  };
  
  powerpcLinuxPkgs = {inherit (allPackages {system = "powerpc-linux";})
    aterm
  ;};
  
  i686FreeBSDPkgs = {inherit (allPackages {system = "i686-freebsd";})
    aterm
    autoconf
    automake19x
    docbook5
    docbook_xml_dtd_42
    docbook_xml_dtd_43
    docbook_xsl
    docbook5_xsl
    libtool
    libxml2
    libxslt
    nxml
    realCurl
    subversion
    unzip
  ;};

  powerpcDarwinPkgs = {inherit (allPackages {system = "powerpc-darwin";})
    apacheHttpd
    aterm
    autoconf
    automake19x
    bison23
    docbook5
    docbook_xml_dtd_42
    docbook_xml_dtd_43
    docbook_xsl
    docbook5_xsl
    libtool
    libxml2
    libxslt
    nxml
    #php
    subversion
    tetex
    unzip
  ;};

  i686DarwinPkgs = {inherit (allPackages {system = "i686-darwin";})
    aterm
    autoconf
    automake19x
    libtool
    libxml2
    libxslt
    subversion
  ;};

  cygwinPkgs = {inherit (allPackages {system = "i686-cygwin";})
    aterm
    gnum4
    readline
    ncurses
  ;};

  body = [
    i686LinuxPkgs
    x86_64LinuxPkgs
    powerpcLinuxPkgs
    i686FreeBSDPkgs
    powerpcDarwinPkgs
    i686DarwinPkgs
    cygwinPkgs
  ];
}
