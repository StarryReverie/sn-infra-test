{
  config,
  inputs,
  withSystem,
  ...
}:
{
  imports = [
    ./colmena.nix
    ./hosts.nix
    ./nodes.nix
    ./secret-registry.nix
  ];
}
