{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.desktop.hyprlock;
in
{
  config = lib.mkIf customCfg.enable {
    users.users.starryreverie.maid = {
      packages = with pkgs; [ hyprlock ];

      file.xdg_config."hypr/hyprlock.conf".source =
        let
          resourcesPkgs = inputs.starrynix-resources.legacyPackages.${pkgs.stdenv.hostPlatform.system};
          wallpaperPackage = resourcesPkgs.wallpaperPackages.minimalism;
        in
        pkgs.replaceVars ./hyprlock.conf {
          backgroundPath = "${wallpaperPackage.wallpaperDir}/wallhaven-2y2wg6.jpg";
        };
    };
  };
}
