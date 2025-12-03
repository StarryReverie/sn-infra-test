{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.wireless = {
    enable = true;
    secretsFile = config.age.secrets."wireless-password.conf".path;
    networks."BIT-Mobile".auth = ''
      key_mgmt=WPA-EAP
      eap=PEAP
      phase2="auth=MSCHAPV2"
      identity="1120233608"
      password=ext:pass_BIT-Mobile
    '';
    extraConfig = "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel";
    allowAuxiliaryImperativeNetworks = true;
  };

  environment.etc."systemd/network/99-wireless-client-dhcp.network.d/50-wireless-bypass-ap-isolation-bit-mobile.conf".text =
    ''
      [Match]
      SSID=BIT-Mobile

      [Route]
      Destination=10.194.0.0/16
      Gateway=10.194.0.1
      Metric=100
    '';

  age.secrets = {
    "wireless-password.conf".rekeyFile = ./wireless-password.conf.age;
  };
}
