{
  config,
  inputs,
  withSystem,
  ...
}:
{
  flake.lib = {
    makeNodeEntryPoint =
      { modules, specialArgs }:
      {
        inherit specialArgs;

        config = {
          imports = modules;
        };

        nixosSystem = inputs.nixpkgs.lib.nixosSystem {
          inherit specialArgs modules;
        };
      };
  };
}
