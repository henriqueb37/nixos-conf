{
  outputs,
  ...
}: {
  imports = [
    outputs.homeManagerModules.default
  ];

  config = {
    home.stateVersion = "24.11";
  };
}
