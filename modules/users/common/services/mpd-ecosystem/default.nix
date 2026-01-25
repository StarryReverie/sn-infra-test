{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./client.nix
    ./daemon.nix
  ];
}
