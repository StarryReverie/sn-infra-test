{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.csl or { };
  customCfg = selfCfg.core.xdg or { };
in
{
  config = {
    custom.users.csl = {
      core.xdg = lib.mkIf (customCfg.enable or false) {
        userDirectories = {
          desktop = "$HOME/desktop";
          documents = "$HOME/documents";
          download = "$HOME/download";
          music = "$HOME/music";
          pictures = "$HOME/pictures";
          publicShare = "$HOME/public-share";
          templates = "$HOME/templates";
          videos = "$HOME/videos";
        };

        mimeApplications = {
          default = {
            # Web
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "text/html" = "firefox.desktop";
          };
        };
      };
    };
  };
}
