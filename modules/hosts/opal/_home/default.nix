{
  self,
  ...
}: {
  imports = (with self.modules.homeManager; [
    direnv
    emacs
    neovim
    zsh
  ]);

  config = {
    home.stateVersion = "24.11";
  };
}
