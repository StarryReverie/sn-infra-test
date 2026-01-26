{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    {
      custom.system.services.transparent-proxy = {
        enable = true;
        wanInterfaces = [ "wlo1" ];
      };
    }
  ];
}
