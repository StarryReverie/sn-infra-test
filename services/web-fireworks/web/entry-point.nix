{ inputs, serviceConstants, ... }@args:
{
  inherit (serviceConstants) system;

  specialArgs = args;

  config = {
    imports = [
      ./service.nix
      inputs.microvm.nixosModules.microvm
    ];

    users.users.root.password = "root";
    services.openssh.enable = true;
    services.openssh.settings.PermitRootLogin = "yes";

    networking.hostName = serviceConstants.hostname;
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
      id = "vmif-cluster0";
      mac = "02:00:00:00:00:01";
    };

    networking.useNetworkd = true;

    systemd.network.enable = true;
    systemd.network.networks."20-lan" = {
      matchConfig.MACAddress = "02:00:00:00:00:01";
      address = [ "172.25.0.1/24" ];
      networkConfig.Gateway = "172.25.0.254";
      networkConfig.DNS = "8.8.8.8";
    };
  };
}
