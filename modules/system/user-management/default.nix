{
  config,
  lib,
  pkgs,
  ...
}:
{
  users.mutableUsers = false;
  services.userborn.enable = true;
  services.userborn.passwordFilesLocation = "/var/lib/nixos";

  preservation.preserveAt."/nix/persistence" = {
    directories = [
      {
        directory = "/var/lib/nixos";
        inInitrd = true;
      }
    ];
  };
}
