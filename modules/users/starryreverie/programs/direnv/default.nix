{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.programs.direnv;
in
let
  configFile = pkgs.writers.writeTOML "direnv.toml" {
    global = {
      log_filter = "^$";
      log_format = "-";
    };
  };
in
{
  config = {
    custom.users.starryreverie = {
      applications.zsh = lib.mkIf customCfg.enable {
        rcContent = ''
          # ===== Direnv integration
          eval "$(${lib.getExe pkgs.direnv} hook zsh)"
        '';
      };
    };

    users.users.starryreverie.maid = lib.mkIf customCfg.enable {
      packages = [ pkgs.direnv ];

      file.xdg_config."direnv/direnv.toml".source = configFile;
      file.xdg_config."direnv/direnvrc".source = ./direnv-stdlib.sh;
      file.xdg_config."direnv/lib/nix-direnv.sh".source = "${pkgs.nix-direnv}/share/nix-direnv/direnvrc";
    };

    preservation.preserveAt."/nix/persistence" = lib.mkIf customCfg.enable {
      users.starryreverie = {
        directories = [ ".local/share/direnv" ];
      };
    };
  };
}
