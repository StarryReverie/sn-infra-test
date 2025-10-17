{
  config,
  lib,
  pkgs,
  constants,
  ...
}:
{
  programs.git.enable = true;

  programs.git.userName = constants.name;
  programs.git.userEmail = constants.email;

  programs.git.difftastic.enable = true;
  programs.git.difftastic.enableAsDifftool = true;
}
