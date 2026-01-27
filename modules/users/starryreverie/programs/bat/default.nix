{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.programs.bat;
in
{
  config = lib.mkIf customCfg.enable {
    users.users.starryreverie.maid = {
      packages = with pkgs; [ bat ];

      file.xdg_config."bat/config".text = ''
        --style="-changes,-numbers,-snip"
        --theme="OneHalfDark"
      '';
    };
  };
}
