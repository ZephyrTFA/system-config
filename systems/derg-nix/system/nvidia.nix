{...}: {
  hardware.graphics = {
    enable = true;
  };
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];
  services.hardware.bolt.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
