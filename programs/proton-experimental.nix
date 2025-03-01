{
  pkgs,
  lib,
  ...
}: let
  proton = pkgs.stdenv.mkDerivation rec {
    name = "proton";
    version = "experimental_9.0";
    src = pkgs.fetchFromGitHub {
      owner = "ValveSoftware";
      repo = "Proton";
      tag = "experimental-9.0-20250218";
      hash = "sha256-Vz/iUKPBxORb/N7CqBOPPtpPNE6gk80ON8ZtYr6oaTA=";
    };

    nativeBuildInputs = with pkgs; [docker git];

    patchPhase = ''
      interpreter=${pkgs.bash}/bin/bash
      echo Patching all files to use $interpreter
      for file in $(find . -type f); do
        if grep -q '/bin/bash' $file; then
          sed -i "s|/bin/bash|$interpreter|" $file
        fi
      done
    '';

    configurePhase = ''
      mkdir -p build
      cd build
      ../configure.sh
    '';

    buildPhase = ''
      echo todo
    '';

    installPhase = ''
      echo todo
    '';
  };
in {
  systemd.tmpfiles = {
    rules = [
      "d /run/proton 0755 root root"
    ];
    packages = [proton];
  };
}
