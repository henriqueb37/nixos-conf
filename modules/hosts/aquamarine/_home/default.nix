{
  self,
  ...
}:
{
  imports = (with self.modules.homeManager; [
    direnv
    emacs
    intellij
    kitty
    neovim
    niri
    syncthing
    vpn
    zsh
  ]);

  config = {
    home.stateVersion = "24.11";
  };
}
