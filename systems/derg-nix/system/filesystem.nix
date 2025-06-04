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
    "/nix/store" = {
      device = "/dev/pool/nix";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=store"
        "compress=zstd"
        "noatime"
      ];
    };
    "/nix/var" = {
      device = "/dev/pool/nix";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=var"
        "compress=zstd"
        "noatime"
      ];
    };
    "/var/log" = {
      device = "/dev/pool/persist";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=log"
        "compress=zstd"
        "noatime"
      ];
    };
    "/persist/user-homes" = {
      device = "/dev/pool/persist";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=home"
        "compress=zstd"
        "noatime"
      ];
    };
    "/persist/steam" = {
      device = "/dev/pool/steam";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "compress=zstd"
        "noatime"
      ];
    };
    "/persist" = {
      device = "/dev/pool/persist";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=persist"
        "compress=zstd"
        "noatime"
      ];
    };
  };

  swapDevices = [{device = "/dev/disk/by-uuid/8db68cf9-64df-441a-85f6-cb5238d61e13";}];
  boot.initrd.availableKernelModules = ["nvme" "usbhid"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.supportedFilesystems = ["btrfs"];
  boot.zfs.forceImportRoot = false;
}
