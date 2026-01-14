{
  config,
  inputs,
  withSystem,
  flakeRoot,
  ...
}:
{
  flake.nixosConfigurations =
    let
      importHost =
        entryPoint:
        import entryPoint {
          inherit inputs flakeRoot;
        };
    in
    {
      "homelab" = importHost (flakeRoot + /hosts/homelab/entry-point.nix);
      "workstation" = importHost (flakeRoot + /hosts/workstation/entry-point.nix);
    };
}
