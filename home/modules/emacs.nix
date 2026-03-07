{
  config,
  pkgs,
  ...
}:
let
  emacs = (
    (pkgs.emacsPackagesFor (
      pkgs.emacs.override {
        toolkit = "lucid";
        withX = true;
        withImageMagick = true;
      }
    )).emacsWithPackages
      (p: [
        p.vterm
        (p.treesit-grammars.with-grammars (
          grammars: with grammars; [
            tree-sitter-nix
            tree-sitter-c
            tree-sitter-cpp
            tree-sitter-python
            tree-sitter-java
            tree-sitter-javascript
            tree-sitter-typescript
            tree-sitter-jsdoc
            tree-sitter-svelte
            tree-sitter-css
            tree-sitter-yaml
            tree-sitter-rust
            tree-sitter-tsx
          ]
        ))
      ])
  );
  emacs-deps = with pkgs; [
    emacs-all-the-icons-fonts
    emacs-lsp-booster
    (hunspell.withDicts (
      dicts: with dicts; [
        pt_BR
        en_US
      ]
    ))
  ];
in
{
  home.packages = emacs-deps;
  programs.emacs.enable = true;
  programs.emacs.package = emacs;
  services.emacs.enable = true;
  services.emacs.package = emacs;
  xdg.configFile."emacs/config.org".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/emacsconf/config.org";
  xdg.configFile."emacs/init.el".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/emacsconf/init.el";
  xdg.configFile."emacs/early-init.el".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/emacsconf/early-init.el";
  xdg.configFile."emacs/eatt" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/emacsconf/eatt";
    recursive = true;
  };
}
