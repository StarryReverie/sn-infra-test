{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.programs.fzf;
in
{
  config = {
    custom.users.starryreverie = {
      applications.zsh = lib.mkIf customCfg.enable {
        environment = {
          FZF_DEFAULT_OPTS = builtins.concatStringsSep " " [
            "--ansi"
            "--reverse"
            "--scroll-off=5"
            "--cycle"
          ];

          FZF_DEFAULT_COMMAND = "fd --color=always .";
        };

        rcContent = ''
          # ===== Fzf integration
          function _fzf_compgen_path() {
              eval "fd ."
          }

          function _fzf_compgen_dir() {
              eval "fd --type d ."
          }

          source <(${lib.getExe pkgs.fzf} --zsh)
        '';
      };
    };

    users.users.starryreverie.maid = lib.mkIf customCfg.enable {
      packages = with pkgs; [ fzf ];
    };
  };
}
