{
  makeNodeEntryPoint =
    nixpkgsLib: specialArgs:
    { modules }:
    {
      inherit specialArgs;

      config = {
        imports = modules;
      };

      nixosSystem = nixpkgsLib.nixosSystem {
        inherit specialArgs modules;
      };
    };
}
