{
  flake.modules.nixos.cli =
  { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      btop
      fastfetch
      fd
      file
      fzf
      gh
      git
      jq
      jujutsu
      ripgrep
      tmux
      tree
      vim
      wget
      yazi
    ];
  };
}
