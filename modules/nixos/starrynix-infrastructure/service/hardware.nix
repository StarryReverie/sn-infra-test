{
  config,
  lib,
  pkgs,
  flakeRoot,
  ...
}:
let
  cfg = config.starrynix-infrastructure.service;
in
{
  config = {
    networking.hostName = lib.mkDefault cfg.nodeInformation.hostName;

    microvm.hypervisor = lib.mkDefault "crosvm";
    microvm.balloon = lib.mkDefault true;
    microvm.vsock.cid = lib.mkDefault (1000 * cfg.clusterInformation.index + cfg.nodeInformation.index);

    microvm.shares = [
      {
        proto = "virtiofs";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
      {
        proto = "virtiofs";
        tag = "flake-root";
        source = "${flakeRoot}";
        mountPoint = "/flake-root";
      }
    ];
  };
}
