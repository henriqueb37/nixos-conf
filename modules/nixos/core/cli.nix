{
  flake.modules.nixos.cli =
  { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      btop
      fastfetch
      fd
      fzf
      git
      gh
      ripgrep
      tmux
      tree
      vim
      wget
      yazi
    ];
  };
}
