{
  config,
  lib,
  pkgs,
  flakeRoot,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.desktop.fcitx5;
in
{
  # Requires the corresponding system module
  imports = [ (flakeRoot + /modules/system/desktop/fcitx5) ];

  config = lib.mkIf customCfg.enable {
    preservation.preserveAt."/nix/persistence" = {
      users.starryreverie = {
        directories = [
          ".config/fcitx5"
          ".local/share/fcitx5"
        ];
      };
    };
  };
}
