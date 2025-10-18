{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.lazygit.enable = true;

  programs.lazygit.settings = {
    gui = {
      language = "en";
      timeFormat = "2006/01/02";
      showRandomTip = false;
      border = "single";
    };
    git = {
      pagers = lib.singleton { useExternalDiffGitConfig = true; };
    };
    update = {
      method = "never";
    };
    disableStartupPopups = true;
  };

  home.shellAliases = {
    lg = "lazygit";
  };
}
