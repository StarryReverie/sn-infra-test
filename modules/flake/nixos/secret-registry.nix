{
  config,
  inputs,
  withSystem,
  self,
  ...
}:
{
  flake.agenix-rekey = inputs.agenix-rekey.configure {
    userFlake = self;
    nixosConfigurations =
      let
        lib = inputs.nixpkgs.lib;

        colmenaNodeConfigurations = (self.colmenaHive.introspect (x: x)).nodes;

        microvmNodeConfigurations = lib.pipe self.nodeConfigurations [
          (lib.attrsets.mapAttrsToList (
            clusterName: cluster:
            lib.attrsets.mapAttrsToList (nodeName: node: {
              name = "${clusterName}-${nodeName}";
              value = node.nixosSystem;
            }) cluster
          ))
          lib.lists.flatten
          lib.attrsets.listToAttrs
        ];
      in
      lib.mergeAttrsList [
        colmenaNodeConfigurations
        microvmNodeConfigurations
      ];
  };
}
