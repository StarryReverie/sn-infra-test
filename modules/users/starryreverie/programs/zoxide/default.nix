{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.programs.zoxide;
in
{
  config = {
    custom.users.starryreverie = {
      applications.zsh = lib.mkIf customCfg.enable {
        rcContent = ''
          # ===== Zoxide integration
          eval "$(${lib.getExe pkgs.zoxide} init zsh --cmd cd)"
        '';
      };
    };

    users.users.starryreverie.maid = lib.mkIf customCfg.enable {
      packages = with pkgs; [ zoxide ];
    };

    preservation.preserveAt."/nix/persistence" = lib.mkIf customCfg.enable {
      users.starryreverie = {
        directories = [ ".local/share/zoxide" ];
      };
    };
  };
}
