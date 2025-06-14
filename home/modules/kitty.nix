{
  config,
  ...
}: {
  xdg.configFile."kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/kitty/kitty.conf";
  xdg.configFile."kitty/themes/moonfly.conf".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/bluz71/vim-moonfly-colors/e984887b5ebeb46598c71f92857de41f750c43aa/extras/moonfly-kitty.conf";
    sha256 = "0090vjn3jnn3imgqwjfsrvacfxcikw8lgx831jvsgyqr48v53kc9";
  };
}
