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

  microvm = {
    vcpu = 1;
    mem = 512;
  };

  time.timeZone = "Asia/Shanghai";

  system.stateVersion = "25.11";
}
