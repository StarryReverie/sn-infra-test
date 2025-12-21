{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;

  services.tailscale.enable = true;
}
