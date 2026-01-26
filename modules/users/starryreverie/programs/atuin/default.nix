{
  config,
  lib,
  pkgs,
  ...
}:
{
  custom.users.starryreverie = {
    applications.zsh = {
      rcContent = ''
        # ===== Atuin integration
        eval "$(${lib.getExe pkgs.atuin} init zsh)"
      '';
    };
  };

  users.users.starryreverie.maid = {
    packages = with pkgs; [ atuin ];

    file.xdg_config."atuin/config.toml".source = ./config.toml;
  };

  preservation.preserveAt."/nix/persistence" = {
    users.starryreverie = {
      directories = [ ".local/share/atuin" ];
    };
  };
}
