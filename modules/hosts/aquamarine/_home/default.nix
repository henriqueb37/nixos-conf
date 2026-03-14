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
    theming
    zsh
  ]);

  config = {
    home.stateVersion = "24.11";
  };
}
