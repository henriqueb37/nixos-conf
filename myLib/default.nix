{
  lib,
  ...
}: rec {
  filesIn = dir:
    builtins.map
    (fname: dir + "/${fname}")
    (builtins.attrNames (builtins.readDir dir));

  fileNameOf = path: (builtins.head (builtins.split "\\." (baseNameOf path)));

  mkOptional = { name, path, origin, ... }@args: { pkgs, config, ... }@margs: let
    module = (import path margs);
    moduleNoImports = builtins.removeAttrs module [ "imports" "options" ];
  in {
    imports = [] ++
      (module.imports or []);
    options =
      lib.recursiveUpdate
      (module.options or {})
      {
        "${origin}"."${name}".enable = lib.mkEnableOption {
          description = "Whether to enable the ${name} ${origin} module.";
        };
      };
    config = (lib.mkIf config."${origin}"."${name}".enable (module.config or moduleNoImports));
  };

  mkModulesOptional = { dir, origin }:
    builtins.map
    (f: let
      fileName = fileNameOf f;
    in (mkOptional {
      name = fileName;
      path = f;
      origin = origin;
    }))
    (filesIn dir);
}
