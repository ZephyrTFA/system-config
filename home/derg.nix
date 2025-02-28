{
  config,
  pkgs,
  ...
}: {
  users.users.derg = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    home = "/persist/user-homes/derg";
    shell = pkgs.fish;
    packages = with pkgs; [vscode vesktop alejandra spotify direnv tuxclocker];
  };
}
