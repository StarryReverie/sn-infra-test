{
  config,
  lib,
  pkgs,
  ...
}:
{
  virtualisation.oci-containers.backend = "podman";

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;

    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };
}
