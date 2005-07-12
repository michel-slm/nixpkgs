buildInputs="$openssl $zlib $db4 $httpd $swig $python $j2sdk $expat $patch"
. $stdenv/setup

configureFlags="--without-gdbm --disable-static"

if test "$localServer"; then
    configureFlags="--with-berkeley-db=$db4 $configureFlags"
fi

if test "$sslSupport"; then
    configureFlags="--with-ssl --with-libs=$openssl $configureFlags"
fi

if test "$httpServer"; then
    configureFlags="--with-apxs=$httpd/bin/apxs --with-apr=$httpd --with-apr-util=$httpd $configureFlags"
    makeFlags="APACHE_LIBEXECDIR=$out/modules $makeFlags"
else
    configureFlags="--without-apxs $configureFlags"
fi

if test -n "$pythonBindings"; then
    configureFlags="--with-swig=$swig $configureFlags"
fi

if test "$javahlBindings"; then
    configureFlags="--enable-javahl --with-jdk=$j2sdk $configureFlags"
fi

installFlags="$makeFlags"


postInstall() {
    if test "$pythonBindings"; then
        make swig-py
        make install-swig-py
    fi
    if test "$javahlBindings"; then
        mkdir -p subversion/bindings/java/javahl/classes # bug fix
        make javahl
        make install-javahl
        mkdir -p $out/share/doc/$name
        $j2sdk/bin/javadoc -d $out/share/doc/$name \
            -windowtitle "JavaHL Subversion Bindings" \
            -link http://java.sun.com/j2se/1.4.2/docs/api/ \
            subversion/bindings/java/javahl/src/org/tigris/subversion/javahl/*.java
    fi
}
postInstall=postInstall


genericBuild
