{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;

  services.tailscale.enable = true;

  preservation.preserveAt."/nix/persistence" = {
    directories = [ "/var/lib/tailscale" ];
  };
}
