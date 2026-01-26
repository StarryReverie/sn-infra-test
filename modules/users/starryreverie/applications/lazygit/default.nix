{
  config,
  lib,
  pkgs,
  ...
}:
{
  custom.users.starryreverie = {
    applications.zsh = {
      shellAliases = {
        lg = "lazygit";
      };
    };
  };

  users.users.starryreverie.maid = {
    packages = with pkgs; [ lazygit ];

    file.xdg_config."lazygit/config.yml".source = ./config.yml;
  };
}
