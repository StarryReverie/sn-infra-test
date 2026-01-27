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
        wanInterfaces = [ "wlo1" ];
      };
    }
  ];
}
