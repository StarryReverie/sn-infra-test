{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../registry
  ];

  options = {
    starrynix-infrastructure.service = {
      name = {
        cluster = lib.mkOption {
          type = lib.types.str;
          description = "The name of the cluster that this service belongs to";
          example = "cluster";
        };

        node = lib.mkOption {
          type = lib.types.str;
          description = "The name of this service node";
          example = "node";
        };
      };

      clusterInformation = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        description = ''
          Information of the cluster that this service belongs to in the
          registry `starrynix-infrastructure.registry` (readonly)
        '';
        readOnly = true;
      };

      nodeInformation = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        description = ''
          Information of this service node in the registry
          `starrynix-infrastructure.registry` (readonly)
        '';
        readOnly = true;
      };
    };
  };

  config =
    let
      registryCfg = config.starrynix-infrastructure.registry;
      serviceCfg = config.starrynix-infrastructure.service;
    in
    {
      starrynix-infrastructure.service = {
        clusterInformation = registryCfg.clusters.${serviceCfg.name.cluster};
        nodeInformation = serviceCfg.clusterInformation.nodes.${serviceCfg.name.node};
      };
    };
}
