#!/bin/bash

if [ -f Build.PL ]; then
    perl Build.PL
    perl ./Build
    perl ./Build test
    perl ./Build install --installdirs site
elif [ -f Makefile.PL ]; then
    perl Makefile.PL INSTALLDIRS=site CC="$(basename "$CC")"
    make
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    make test
fi
    make install
else
    echo 'Unable to find Build.PL or Makefile.PL. You need to modify build.sh.'
    exit 1
fi

