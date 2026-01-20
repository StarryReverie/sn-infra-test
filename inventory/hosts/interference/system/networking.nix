{
  config,
  lib,
  pkgs,
  ...
}:
{
  age.secrets."10-ens18.network".rekeyFile = ./10-ens18.network.age;

  environment.etc."systemd/network/10-ens18.network" = {
    source = config.age.secrets."10-ens18.network".path;
  };
}
