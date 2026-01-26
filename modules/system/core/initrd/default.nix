{
  config,
  lib,
  pkgs,
  ...
}:
let
  customCfg = config.custom.system.core.initrd;
in
{
  config = lib.mkIf customCfg.enable {
    system.nixos-init.enable = true;
    boot.initrd.systemd.enable = true;
  };
}
