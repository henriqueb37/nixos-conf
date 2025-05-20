{
  lib,
  ...
}: {
  config = {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.extraConfig."00-default-volume" = {
        "wireplumber.settings" = {
          "device.routes.default-sink-volume" = "0.16";
        };
      };
    };
  };
}
