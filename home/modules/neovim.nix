{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [ lazygit ];
  programs.neovim.enable = true;
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/henrique/.dotfiles/.config/nvim";
    recursive = true;
  };
}
