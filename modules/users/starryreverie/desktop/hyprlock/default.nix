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

      file.xdg_config."hypr/hyprlock.conf".text =
        let
          resourcesPkgs = inputs.starrynix-resources.legacyPackages.${pkgs.stdenv.hostPlatform.system};
          wallpaperPackage = resourcesPkgs.wallpaperPackages.minimalism;
        in
        ''
          ${builtins.readFile ./hyprlock.template.conf}

          background {
              path = ${wallpaperPackage.wallpaperDir}/wallhaven-2y2wg6.jpg
              blur_passes = 2
              blur_size = 5
          }
        '';
    };

    security.pam.services.hyprlock = { };
  };
}
