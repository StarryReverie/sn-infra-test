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

  home.shellAliases = {
    ga = "git add . && git status";
    gd = "git diff HEAD";
    gl = "git log --pretty='format:%C(yellow)%h %C(blue)%ad %C(white)%s' --graph --date=short";
    gp = "git push";
    gpr = "git pull --rebase";
    gs = "git status";
  };
}
