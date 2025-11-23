{
  config,
  lib,
  pkgs,
  constants,
  ...
}:
{
  users.users.${constants.username}.maid = {
    file.xdg_config."niri/config.kdl".text = lib.mkBefore ''
      debug {
          render-drm-device "/dev/dri/renderD129"
      }

      output "eDP-1" {
          off
          mode "2560x1440@240.000"
          scale 2
          transform "normal"
          position x=0 y=0
      }

      output "HDMI-A-1" {
          mode "2560x1440@144.001"
          scale 2
          transform "normal"
          position x=0 y=0
      }
    '';
  };
}
