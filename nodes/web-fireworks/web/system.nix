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
  };

  microvm.vcpu = 1;
  microvm.mem = 256;

  system.stateVersion = "25.11";
}
