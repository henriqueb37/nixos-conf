{
  flake.modules.nixos.uni-stuff =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options = {
        myNixos.uni-stuff = {
          bd.enable = lib.mkEnableOption {
            description = "Whether to enable BD discipline stuff";
            default = false;
          };
        };
      };
      config = {
        environment.systemPackages =
          [ ]
          ++ lib.optionals config.myNixos.uni-stuff.bd.enable [
            pkgs.lazarus-qt6
          ];

        # services.mysql = lib.mkIf config.myNixos.uni-stuff.bd.enable {
        #   enable = true;
        #   package = pkgs.mysql80;
        # };
      };
    };
}
