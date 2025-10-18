{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.zellij.enable = true;

  xdg.configFile."zellij/config.kdl".source = pkgs.substitute {
    src = ./config.kdl;
    substitutions = [
      "--replace-fail"
      "@@%%xdg-config-home%%@@"
      "${config.xdg.configHome}"
    ];
  };

  xdg.configFile."zellij/layouts" = {
    source = ./layouts;
    recursive = true;
  };

  home.shellAliases = {
    zj = "zellij";
    zd = "zellij --layout development";
  };
}
