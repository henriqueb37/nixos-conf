{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [ lazygit ];
  programs.neovim.enable = true;
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/nvim";
    recursive = true;
  };
}
