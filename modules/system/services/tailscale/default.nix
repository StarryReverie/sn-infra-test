{
  config,
  lib,
  pkgs,
  ...
}:
let
  customCfg = config.custom.system.services.tailscale;
in
{
  config = lib.mkIf customCfg.enable {
    services.tailscale.enable = true;

    preservation.preserveAt."/nix/persistence" = {
      directories = [ "/var/lib/tailscale" ];
    };
  };
}
