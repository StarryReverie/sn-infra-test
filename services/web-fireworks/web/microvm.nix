{
  config,
  lib,
  pkgs,
  inputs,
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

  networking.hostName = serviceCfg.nodeInformation.hostName;
  networking.useDHCP = false;

  microvm.hypervisor = "qemu";
  microvm.vcpu = 1;
  microvm.mem = 256;

  microvm.shares = inputs.nixpkgs.lib.singleton {
    proto = "virtiofs";
    tag = "ro-store";
    source = "/nix/store";
    mountPoint = "/nix/.ro-store";
  };

  microvm.interfaces = inputs.nixpkgs.lib.singleton {
    type = "tap";
    id = serviceCfg.nodeInformation.networkInterface;
    mac = serviceCfg.nodeInformation.macAddress;
  };

  networking.useNetworkd = true;

  systemd.network.enable = true;
  systemd.network.networks."20-lan" = {
    matchConfig.MACAddress = serviceCfg.nodeInformation.macAddress;
    address = [ serviceCfg.nodeInformation.ipv4AddressCidr ];
    networkConfig.Gateway = serviceCfg.clusterInformation.gatewayIpv4Address;
  };

  system.stateVersion = "25.11";
}
