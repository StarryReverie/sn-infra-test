{
  config,
  lib,
  pkgs,
  options,
  ...
}:
let
  customSubmodule =
    { name, ... }:
    {
      # Mirrors the structure of system-scoped `custom.system.<domain>.<feature>`.
      options.custom = lib.attrsets.mapAttrs (
        domain: perDomain:
        lib.attrsets.mapAttrs (feature: perFeature: {
          enable = lib.mkOption {
            type = lib.types.bool;
            description = "Whether to user-scoped feature option `custom.${domain}.${feature}`";
            default = false;
            example = true;
          };
        }) perDomain
      ) options.custom.system;
    };
in
{
  options.users.users = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule customSubmodule);
  };
}
