{
  lib,
  ...
}: rec {
  filesIn = dir: (map (fname: dir + fname)
    (builtins.attrNames (builtins.readDir dir)));

  fileNameOf = path: (builtins.head (builtins.split "\\." (baseNameOf path)));

  mkOptional = { name, path, origin, default ? false, ... }@args: { config, ... }@margs: let
    module = (import path margs);
  in {
    imports = [
      (module.imports or [])
    ];
    options = module.options ++ {
      "${origin}"."${name}".enable = lib.mkEnableOption {
        inherit default;
        description = "Whether to enable the ${name} ${origin} module.";
      };
    };
    config = lib.mkIf config."${origin}"."${name}".enable module.config;
  };

  mkModulesOptional = { dir, origin, default }:
    builtins.map
    (f: let
      fileName = fileNameOf f;
    in (mkOptional {
      name = fileName;
      path = f;
      inherit origin default;
    }))
    (filesIn dir);
}
