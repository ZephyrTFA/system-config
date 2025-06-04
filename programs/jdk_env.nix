{
  config,
  pkgs,
  ...
}: let
  jdkEnv =
    pkgs.runCommand "jdk-env" {
      buildInputs = with pkgs; [
        pkgs.openjdk17
        pkgs.openjdk21
      ];
    } ''
      mkdir -p $out/jdks
      ln -s ${pkgs.openjdk17}/lib/openjdk $out/jdks/openjdk17
      ln -s ${pkgs.openjdk21}/lib/openjdk $out/jdks/openjdk21
    '';
in {
  environment.pathsToLink = ["/jdks"];

  environment.systemPackages = [
    jdkEnv
  ];

  system.activationScripts.jdkSymlinks.text = ''
    mkdir -p /opt
    chmod 755 /opt
    ln -sfT /run/current-system/sw/jdks /opt/java
  '';
}
