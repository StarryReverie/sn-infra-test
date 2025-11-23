{
  config,
  lib,
  pkgs,
  ...
}:
{
  wrappers.mako.basePackage = pkgs.mako;

  wrappers.mako.prependFlags = [
    "--config"
    "${./config}"
  ];
}
