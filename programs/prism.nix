{
  lib,
  pkgs,
  javaVersions ? [
    {
      tag = "jdk-23.0.2";
      hash = "sha256-DPY+iBU7dZE2lHwU8AQsUVrh/5q/NG8UPcR68GWx1t0=";
    }
    {
      tag = "jdk-17.0.9";
      hash = "sha256-5HunIpzvAjk+GdW49G9/HKtIKd0Xv+hNVDH8j/DiKpY=";
    }
  ],
}: let
  graal = {
    tag,
    hash,
  }:
    pkgs.graalvmCEPackages.buildGraalvm {
      useMusl = lib.meta.availableOn pkgs.stdenv.hostPlatform pkgs.musl;
      src = pkgs.fetchurl {
        inherit hash;
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/${tag}/graalvm-community-${tag}_linux-x64_bin.tar.gz";
      };
      version = builtins.substring 1 (builtins.stringLength tag) tag;
      doInstallCheck = false;
    };
in {
  prism = pkgs.prismlauncher.override {
    jdks = builtins.map graal javaVersions;
  };
}
