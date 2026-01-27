{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.programs.atuin;
in
{
  config = {
    custom.users.starryreverie = {
      applications.zsh = lib.mkIf customCfg.enable {
        rcContent = ''
          # ===== Atuin integration
          eval "$(${lib.getExe pkgs.atuin} init zsh)"
        '';
      };
    };

    users.users.starryreverie.maid = lib.mkIf customCfg.enable {
      packages = with pkgs; [ atuin ];

      file.xdg_config."atuin/config.toml".source = ./config.toml;
    };

    preservation.preserveAt."/nix/persistence" = lib.mkIf customCfg.enable {
      users.starryreverie = {
        directories = [ ".local/share/atuin" ];
      };
    };
  };
}
