{
  config,
  lib,
  pkgs,
  ...
}:
{
  wrappers.swaync.basePackage = pkgs.swaynotificationcenter;

  wrappers.swaync.programs.swaync = {
    prependFlags = [
      "--config"
      "${./config.json}"
      "--style"
      "${./style.css}"
    ];
  };

  wrappers.swaync.programs.swaync-client = { };
}
