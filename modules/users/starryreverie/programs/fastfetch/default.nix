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
        ff = "fastfetch";
      };
    };
  };

  users.users.starryreverie.maid = {
    packages = with pkgs; [ fastfetchMinimal ];
  };

}
