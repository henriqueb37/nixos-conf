{ ... }: {
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "schedutil";
  };
  hardware.system76.power-daemon.enable = true;
  services.system76-scheduler.enable = true;
}
