{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.difftastic.enable = true;
  programs.difftastic.git.enable = true;
  programs.difftastic.git.diffToolMode = true;
}
