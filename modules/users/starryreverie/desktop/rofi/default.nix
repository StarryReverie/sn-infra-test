{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.desktop.rofi;
in
{
  config = lib.mkIf customCfg.enable {
    users.users.starryreverie.maid = {
      packages = with pkgs; [ rofi ];

      file.xdg_config."rofi/config.rasi".source = ./config.rasi;
    };
  };
}
