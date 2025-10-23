{
  config,
  lib,
  pkgs,
  serviceConstants,
  flakeRoot,
  ...
}:
let
  serviceCfg = config.starrynix-infrastructure.service;
in
{
  imports = [
    (flakeRoot + /modules/nixos/starrynix-infrastructure/service)
    (flakeRoot + /services/registry.nix)
  ];

  starrynix-infrastructure.service = {
    name = {
      inherit (serviceConstants) cluster node;
    };
  };

  users.users.root.password = "root";
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  microvm.vcpu = 1;
  microvm.mem = 256;

  system.stateVersion = "25.11";
}
