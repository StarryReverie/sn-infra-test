{
  config,
  lib,
  pkgs,
  constants,
  flakeRoot,
  ...
}:
{
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  services.dae.wanInterfaces = [ "eth0" ];
}
