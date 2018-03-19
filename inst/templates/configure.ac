# Run `autoconf` to generate the configure script.

AC_INIT([{{{ Package }}}])

# Switch to a C++. If you are using C you may want to remove these lines.
AC_LANG(C++)
AC_PROG_CPP

# This is an example of searching for a system library, in this case the zlib
# compression library (which contains the function 'deflate').
#
# See the PKG_LIBS settings below for how 'ac_cv_search_deflate' is used to
# identify the library flag.
AC_SEARCH_LIBS(deflate, z, [], [AC_ERROR([The zlib library is required.])])
AC_CHECK_HEADERS(zlib.h, [], [AC_ERROR([The zlib library headers are required.])])

# Find the compiler and compiler flags used by R.
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi
RBIN="${R_HOME}/bin/R"
CC=`"${RBIN}" CMD config CC`
CFLAGS=`"${RBIN}" CMD config CFLAGS`
CPPFLAGS=`"${RBIN}" CMD config CPPFLAGS`
CPICFLAGS=`"${RBIN}" CMD config CPICFLAGS`

# Set the flags used by R to compile packages in the src/Makevars file.
PKG_CFLAGS="${PKG_CFLAGS}"
PKG_CPPFLAGS="${PKG_CPPFLAGS}"
PKG_LIBS="${PKG_LIBS} ${ac_cv_search_deflate}"

AC_SUBST([PKG_CFLAGS], ["${PKG_CFLAGS}"])
AC_SUBST([PKG_CPPFLAGS], ["${PKG_CPPFLAGS}"])
AC_SUBST([PKG_LIBS], ["${PKG_LIBS}"])
AC_CONFIG_FILES([src/Makevars])

echo "
  --------------------------------------------------
  Configuration for {{{ Package }}}:

    cflags:     ${PKG_CFLAGS}
    cppflags:   ${PKG_CPPFLAGS}
    libs:       ${PKG_LIBS}

  --------------------------------------------------
"

AC_OUTPUT
