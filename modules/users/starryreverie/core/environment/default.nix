{
  config,
  lib,
  pkgs,
  flakeRoot,
  ...
}:
{
  imports = [
    (flakeRoot + /modules/users/common/core/environment)
  ];

  custom.users.starryreverie = {
    core.environment = {
      enable = true;
    };
  };

  preservation.preserveAt."/nix/persistence" = {
    users.starryreverie = {
      directories = [ ".config/environment.d" ];
    };
  };
}
