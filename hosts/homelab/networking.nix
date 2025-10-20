{
  config,
  lib,
  pkgs,
  constants,
  ...
}:
{
  networking.useDHCP = lib.mkDefault true;

  networking.wireless = {
    enable = true;
    secretsFile = "/etc/nixos/wireless.conf";
    networks."BIT-Mobile".auth = ''
      key_mgmt=WPA-EAP
      eap=PEAP
      phase2="auth=MSCHAPV2"
      identity="1120233608"
      password=ext:pass_university
    '';
    extraConfig = "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel";
    allowAuxiliaryImperativeNetworks = true;
  };

  networking.useNetworkd = true;
  systemd.network.enable = true;

  systemd.network.netdevs."10-microvm".netdevConfig = {
    Kind = "bridge";
    Name = "microvm";
  };

  systemd.network.networks."10-microvm" = {
    matchConfig.Name = "microvm";
    address = [ "172.25.0.254/24" ];
    networkConfig = {
      IPv4Forwarding = true;
    };
  };

  systemd.network.networks."11-microvm" = {
    matchConfig.Name = "vmif-*";
    networkConfig.Bridge = "microvm";
  };

  networking.nat = {
    enable = true;
    externalInterface = "wlp3s0";
    internalInterfaces = [ "microvm" ];

    forwardPorts = [
      {
        proto = "tcp";
        sourcePort = 8080;
        destination = "172.25.0.1:80";
      }
    ];
  };

  networking.firewall.enable = true;
  networking.nftables.enable = true;
  networking.firewall.allowedTCPPorts = [ 8080 ];
}
