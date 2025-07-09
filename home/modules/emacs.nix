{
  config,
  pkgs,
  ...
}: let
  emacs = with pkgs; (
    (emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (
      p: [ p.vterm ]
    )
  );
in {
  programs.emacs.enable = true;
  programs.emacs.package = emacs;
  services.emacs.enable = true;
  services.emacs.package = emacs;
  xdg.configFile."emacs" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/emacsconf";
    recursive = true;
  };
}
