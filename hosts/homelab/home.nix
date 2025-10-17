{
  config,
  lib,
  pkgs,
  constants,
  flakeRoot,
  ...
}:
{
  imports = [
    (flakeRoot + /modules/home/direnv)
    (flakeRoot + /modules/home/git)
    (flakeRoot + /modules/home/helix)
    (flakeRoot + /modules/home/zsh)
  ];

  home.username = constants.username;
  home.homeDirectory = "/home/${constants.username}";

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
