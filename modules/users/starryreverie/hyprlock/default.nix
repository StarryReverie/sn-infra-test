{
  config,
  lib,
  pkgs,
  ...
}:
{
  users.users.starryreverie.maid = {
    packages = with pkgs; [ hyprlock ];

    file.xdg_config."hypr/hyprlock.conf".source = ./hyprlock.conf;
  };

  security.pam.services.hyprlock = { };
}
