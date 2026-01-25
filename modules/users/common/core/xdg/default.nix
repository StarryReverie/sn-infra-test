{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./mime-applications.nix
    ./user-directories.nix
  ];
}
