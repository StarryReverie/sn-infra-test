{
  config,
  lib,
  pkgs,
  ...
}:
let
  customCfg = config.custom.system.services.ly;
in
{
  config = lib.mkIf customCfg.enable {
    services.displayManager.ly.enable = true;

    services.displayManager.ly.x11Support = false;

    services.displayManager.ly.settings = {
      animation = "matrix";
      session_log = ".local/state/ly-session.log";
    };
  };
}
