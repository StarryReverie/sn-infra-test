{
  config,
  inputs,
  self,
  flakeRoot,
  ...
}:
{
  flake.nixosConfigurations =
    let
      importApplyHost =
        entryPoint:
        import entryPoint {
          inherit inputs flakeRoot;
        };
    in
    {
      "interference" = importApplyHost (flakeRoot + /inventory/hosts/interference/entry-point.nix);
      "superposition" = importApplyHost (flakeRoot + /inventory/hosts/superposition/entry-point.nix);
      "topological" = importApplyHost (flakeRoot + /inventory/hosts/topological/entry-point.nix);
    };
}
