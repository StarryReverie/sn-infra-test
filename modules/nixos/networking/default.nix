{
  config,
  lib,
  pkgs,
  ...
}:
{
  systemd.network.enable = true;
  networking.useNetworkd = true;

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  environment.etc."systemd/network/99-wireless-client-dhcp.network.d/40-disable-dhcp-dns.conf".text =
    ''
      [DHCPv4]
      UseDNS=false

      [DHCPv6]
      UseDNS=false
    '';

  environment.etc."systemd/network/99-ethernet-default-dhcp.network.d/40-disable-dhcp-dns.conf".text =
    ''
      [DHCPv4]
      UseDNS=false

      [DHCPv6]
      UseDNS=false
    '';
}
