{
  flake.modules.homeManager.emacs =
    { config, pkgs, ... }:
    let
      # This is for svelte-ts-mode
      tree-sitter-grammars-svelte = pkgs.tree-sitter.buildGrammar {
        language = "svelte";
        version = "v1.0.2";
        src = pkgs.fetchFromGitHub {
          owner = "tree-sitter-grammars";
          repo = "tree-sitter-svelte";
          rev = "774a65aea563accc35f5d45fafa4d96ec5761f57";
          hash = "sha256-mkw3s0pZQ6ry+fiTk2fJeKVA7Nqyv2Z2R1AFZknzpFM=";
        };
      };

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
            (
              p.treesit-grammars.with-grammars (
                grammars: with grammars; [
                  tree-sitter-nix
                  tree-sitter-c
                  tree-sitter-cpp
                  tree-sitter-python
                  tree-sitter-java
                  tree-sitter-javascript
                  tree-sitter-typescript
                  tree-sitter-jsdoc
                  tree-sitter-css
                  tree-sitter-yaml
                  tree-sitter-rust
                  tree-sitter-tsx
                  tree-sitter-grammars-svelte
                ]
              )
            )
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
    };
}
