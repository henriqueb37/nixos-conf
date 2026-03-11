{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.roboto-mono
        nerd-fonts.recursive-mono
        recursive
      ];
    };
}
