{
  flake.modules.homeManager.neovim =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [ lazygit ];
      programs.neovim = {
        enable = true;
        plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
      };
      xdg.configFile."nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/nvim";
        recursive = true;
      };
    };
}
