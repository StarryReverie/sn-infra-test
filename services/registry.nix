{
  config,
  lib,
  pkgs,
  flakeRoot,
  ...
}:
{
  imports = [ (flakeRoot + /modules/nixos/starrynix-infrastructure/registry) ];

  starrynix-infrastructure.registry.clusters = {
    "web-fireworks" = {
      index = 1;
      nodes."web".index = 1;
    };
  };

  starrynix-infrastructure.registry.clusters = {
    "web-fireworks".nodes."web".sshKey = {
      mount = true;
      type = "ed25519";
      publicKeyFile = flakeRoot + /services/web-fireworks/web/ssh-keys/ed25519.pub;
      encryptedPrivateKeyFile = flakeRoot + /services/web-fireworks/web/ssh-keys/ed25519.age;
    };
  };
}
