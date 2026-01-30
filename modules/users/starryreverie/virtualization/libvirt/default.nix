{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.virtualization.libvirt;
in
{
  config = lib.mkIf customCfg.enable {
    users.users.starryreverie = {
      extraGroups = [ "libvirtd" ];
    };
  };
}
