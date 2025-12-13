{
  config,
  lib,
  pkgs,
  constants,
  ...
}:
{
  users.users.${constants.username}.maid = {
    packages = with pkgs; [ rofi ];

    file.xdg_config."rofi/config.rasi".source = ./config.rasi;
  };
}
