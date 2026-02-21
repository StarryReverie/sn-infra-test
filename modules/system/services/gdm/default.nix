{
  config,
  lib,
  pkgs,
  ...
}:
let
  customCfg = config.custom.system.services.gdm;
in
{
  config = lib.mkIf customCfg.enable {
    services.displayManager.gdm.enable = true;

    services.displayManager.gdm.autoSuspend = false;
  };
}
