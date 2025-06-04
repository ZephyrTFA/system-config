let
  derg =
    (import ../../users/derg.nix {
      config = {};
      pkgs = {};
      home-manager = {};
    }).users.users.derg.openssh.authorizedKeys.keys;

  derg-nix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEnM+b9SQQHZz91t0V3C0hEHDdwoRSlV+uvRaqEOgvY root@derg-nix";
in {
}
