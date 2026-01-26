{
  config,
  lib,
  pkgs,
  flakeRoot,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.core.environment;
in
{
  imports = [
    (flakeRoot + /modules/users/common/core/environment)
  ];

  config = lib.mkIf customCfg.enable {
    preservation.preserveAt."/nix/persistence" = {
      users.starryreverie = {
        directories = [ ".config/environment.d" ];
      };
    };
  };
}
