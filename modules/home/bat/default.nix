{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.bat.enable = true;

  programs.bat.config = {
    theme = "OneHalfDark";
    style = "header,header-filesize,grid";
  };
}
