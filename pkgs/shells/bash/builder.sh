#! /bin/sh -e
. $stdenv/setup
genericBuild
(cd $out/bin && ln -s bash sh) || exit 1
