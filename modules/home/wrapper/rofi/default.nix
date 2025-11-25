{
  config,
  lib,
  pkgs,
  ...
}:
{
  wrappers.rofi.basePackage = pkgs.rofi;

  wrappers.rofi.prependFlags = [
    "-config"
    "${./config.rasi}"
  ];
}
