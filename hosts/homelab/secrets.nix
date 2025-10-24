{
  config,
  lib,
  pkgs,
  flakeRoot,
  ...
}:
{
  age.secrets = {
    "wireless-password.conf".rekeyFile = flakeRoot + /secrets/wireless-password.conf.age;
  };
}
