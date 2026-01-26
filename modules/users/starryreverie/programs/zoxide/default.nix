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
        # ===== Zoxide integration
        eval "$(${lib.getExe pkgs.zoxide} init zsh --cmd cd)"
      '';
    };
  };

  users.users.starryreverie.maid = {
    packages = with pkgs; [ zoxide ];
  };

  preservation.preserveAt."/nix/persistence" = {
    users.starryreverie = {
      directories = [ ".local/share/zoxide" ];
    };
  };
}
