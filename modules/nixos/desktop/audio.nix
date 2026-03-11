{
  flake.modules.nixos.audio =
    { ... }:
    {
      config = {
        services.pipewire = {
          enable = true;
          alsa.enable = true;
          pulse.enable = true;
          alsa.support32Bit = true;
          wireplumber.extraConfig."00-default-volume" = {
            "wireplumber.settings" = {
              "device.routes.default-sink-volume" = "0.16";
            };
          };
          extraConfig.pipewire."99-virtual-null-sink" = {
            "context.objects" = [
              {
                factory = "adapter";
                args = {
                  "factory.name" = "support.null-audio-sink";
                  "node.name" = "Virtual-Speaker";
                  "node.description" = "Virtual Audio Source";
                  "media.class" = "Audio/Sink";
                  "audio.position" = "FL,FR";
                };
              }
            ];
          };
        };
      };
    };
}
