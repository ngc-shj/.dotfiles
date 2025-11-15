# TCL/TK
if [[ -d /usr/local/opt/tcl-tk/ ]]; then
    export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/tcl-tk/lib $LDFLAGS"
    export CPPFLAGS="-I/usr/local/opt/tcl-tk/include $CPPFLAGS"
    export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig:$PKG_CONFIG_PATH"
fi
