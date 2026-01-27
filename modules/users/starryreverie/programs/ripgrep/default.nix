{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.programs.ripgrep;
in
{
  config = lib.mkIf customCfg.enable {
    users.users.starryreverie.maid = {
      packages = [
        (inputs.wrapper-manager.lib.wrapWith pkgs {
          basePackage = pkgs.ripgrep;

          prependFlags = [
            "--smart-case"

            "--glob=!**/node_modules/**"
            "--glob=!**/dist/**"
            "--glob=!**/{,_}build/**"
            "--glob=!**/target/**"
            "--glob=!**/{,.}venv/**"
            "--glob=!**/__pycache__/**"
            "--glob=!**/vendor/**"
            "--glob=!**/pkg/**"
            "--glob=!**/bin/**"
            "--glob=!**/.gradle/**"
          ];
        })
      ];
    };
  };
}
