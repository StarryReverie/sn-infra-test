{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.applications.steam;
in
{
  config = lib.mkIf customCfg.enable {
    preservation.preserveAt."/nix/persistence" = {
      users.starryreverie = {
        directories = [
          ".local/share/Steam"
          ".steam"
        ];
      };
    };
  };
}
