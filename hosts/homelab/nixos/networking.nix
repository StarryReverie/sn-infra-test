{
  config,
  lib,
  pkgs,
  constants,
  flakeRoot,
  ...
}:
let
  clusters = config.starrynix-infrastructure.registry.clusters;
in
{
  networking.nameservers = lib.mkForce [ clusters."dns".nodes."main".ipv4Address ];

  services.dae = {
    wanInterfaces = [ "wlp3s0" ];
    lanInterfaces = config.starrynix-infrastructure.host.networking.internalInterfaces;
    forwardDns = false;
  };
}
