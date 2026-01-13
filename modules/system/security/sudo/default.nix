{
  config,
  lib,
  pkgs,
  ...
}:
{
  security.sudo-rs.enable = true;

  security.sudo-rs.execWheelOnly = true;

  security.sudo-rs.extraConfig = ''
    Defaults:%wheel timestamp_timeout=10
  '';
}
