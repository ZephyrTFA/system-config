{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    xfsprogs
    xfsdump
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/080a1cb7-9a5d-4ea5-aaaf-996ba33c1e8b";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/D11A-F85A";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  swapDevices = [{device = "/dev/disk/by-uuid/8db68cf9-64df-441a-85f6-cb5238d61e13";}];

  boot.initrd.availableKernelModules = ["nvme" "usbhid"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
}
