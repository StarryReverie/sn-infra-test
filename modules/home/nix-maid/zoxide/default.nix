{
  config,
  lib,
  pkgs,
  constants,
  ...
}:
{
  users.users.${constants.username} = {
    maid = {
      packages = with pkgs; [ zoxide ];
    };

    custom.zsh = {
      rcContent = ''
        # Zoxide integration
        eval "$(${lib.getExe pkgs.zoxide} init zsh --cmd cd)"
      '';
    };
  };
}
