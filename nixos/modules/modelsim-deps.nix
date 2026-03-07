{
  pkgs,
  inputs,
  ...
}: {
  # 32 bit dependencies
  # Since these don't seem to be cached, I gotta download and recompile the dependencies for the fhs
  # everytime that I clean the garbage from the store.
  # So I'm downloading it as a system dependency to avoid that.
  # TODO: make it a fixed nixpkgs version too
  environment.systemPackages = with inputs.nixpkgs.legacyPackages.i686-linux; [
    stdenv.cc.cc.lib
    ncurses
    libuuid
    zlib
    glib
    libxcrypt-legacy
    libpng12
    freetype
    fontconfig.lib
    xorg.libSM
    xorg.libICE
    xorg.libXrender
    xorg.libXext
    xorg.libX11
    xorg.libXtst
    xorg.libXi
    xorg.libXft
    xorg.xcbutil
    xorg.libxcb.out
    xorg.xcbutilrenderutil.out
    xorg.libXau
    xorg.libXdmcp
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    gtk2
    libelf
    expat
    dbus.lib
    brotli.lib
    libpng
    bzip2.out
  ];
}
