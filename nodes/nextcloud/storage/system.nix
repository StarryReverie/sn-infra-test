{
  config,
  lib,
  pkgs,
  nodeConstants,
  ...
}:
{
  starrynix-infrastructure.node = {
    name = {
      inherit (nodeConstants) cluster node;
    };

    states = {
      "minio".mountPoint = "/var/lib/minio";
    };
  };

  microvm = {
    vcpu = 1;
    mem = 512;
  };

  system.stateVersion = "25.11";
}
