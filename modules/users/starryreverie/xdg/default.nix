{
  config,
  lib,
  pkgs,
  flakeRoot,
  ...
}:
{
  imports = [
    (flakeRoot + /modules/users/common/xdg)
  ];

  users.users.starryreverie = {
    custom.xdg = {
      enable = true;

      userDirectories = {
        desktop = "$HOME/desktop";
        documents = "$HOME/userdata/documents";
        download = "$HOME/downloads";
        music = "$HOME/userdata/music";
        pictures = "$HOME/userdata/pictures";
        publicShare = "$HOME/public";
        templates = "$HOME/userdata/templates";
        videos = "$HOME/userdata/videos";
      };
    };
  };
}
