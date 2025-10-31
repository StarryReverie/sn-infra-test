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
      "nextcloud".mountPoint = "/var/lib/nextcloud";
      "postgresql".mountPoint = "/var/lib/postgresql";
    };
  };

  microvm = {
    vcpu = 1;
    mem = 1024;
  };

  system.stateVersion = "25.11";
}
