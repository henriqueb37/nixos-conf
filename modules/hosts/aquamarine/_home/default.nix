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
    nixDev
    syncthing
    vpn
    zsh
  ]);

  config = {
    home.stateVersion = "24.11";
  };
}
