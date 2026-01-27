{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.desktop.waybar;
in
{
  config = lib.mkIf customCfg.enable {
    users.users.starryreverie.maid = {
      packages = with pkgs; [
        waybar
        brightnessctl
        nerd-fonts.symbols-only
      ];

      file.xdg_config."waybar/config.jsonc".source = ./config.jsonc;
      file.xdg_config."waybar/style.css".source = ./style.css;
    };
  };
}
