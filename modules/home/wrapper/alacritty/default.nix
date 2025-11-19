{
  config,
  lib,
  pkgs,
  ...
}:
{
  wrappers.alacritty.basePackage = pkgs.alacritty;

  wrappers.alacritty.prependFlags = [
    "--config-file"
    "${./alacritty.toml}"
  ];
}
