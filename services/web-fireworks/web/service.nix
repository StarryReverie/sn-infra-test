{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [ dig ];
  networking.firewall.enable = false;
  services.nginx.enable = true;
  services.nginx.virtualHosts."web" = {
    listenAddresses = [ "0.0.0.0" ];
    root = ./resources;
  };
}
