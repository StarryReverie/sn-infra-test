{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.csl or { };
  customCfg = selfCfg.security.password or { };
in
{
  config = lib.mkIf (customCfg.enable or false) {
    users.users.csl = {
      hashedPassword = "$y$j9T$EDR1LjqC/0lZAIE7ctBtD.$iE32HIfvJmCxHm2nrOlwALAAUzlvMfEGueelLX0vz2C";
    };
  };
}
