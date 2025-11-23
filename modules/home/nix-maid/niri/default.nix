{
  config,
  lib,
  pkgs,
  constants,
  ...
}:
{
  users.users.${constants.username}.maid = {
    file.xdg_config."niri/config.kdl".text = lib.mkAfter (builtins.readFile ./config.kdl);
  };
}
