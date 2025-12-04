{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;
  services.displayManager.ly.enable = true;

  services.tailscale.enable = true;
}
