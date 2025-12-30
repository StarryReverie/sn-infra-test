{
  config,
  lib,
  pkgs,
  ...
}:
{
  users.mutableUsers = false;
  services.userborn.enable = true;

  preservation.preserveAt."/nix/persistence" = {
    directories = [
      {
        directory = "/var/lib/nixos";
        inInitrd = true;
      }
    ];
  };
}
