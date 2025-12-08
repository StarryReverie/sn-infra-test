{
  config,
  lib,
  pkgs,
  constants,
  flakeRoot,
  ...
}:
{
  services.dae = {
    wanInterfaces = [ "wlo1" ];
    forwardDns = true;
  };
}
