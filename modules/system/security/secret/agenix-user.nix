{
  config,
  lib,
  pkgs,
  ...
}:
let
  topCfg = config;
  ageCfg = config.age;

  secretSubmodule =
    { config, ... }:
    {
      options.configureForUser = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = ''
          Automatically configure the secret's ownership and access permission for a given user.
          Make sure that you prefix your secret's name with some unique identity, such as your
          username. This option doesn't create a new namespace for user-specific secrets.
        '';
        default = null;
        example = "example-user";
      };

      config = lib.mkIf (config.configureForUser != null) {
        owner =
          topCfg.users.users.${config.configureForUser}.name
            or "$(${pkgs.coreutils}/bin/id -u ${config.configureForUser})";
        group =
          topCfg.users.users.${config.configureForUser}.group
            or "$(${pkgs.coreutils}/bin/id -g ${config.configureForUser})";
        # Use `${ageCfg.secretsDir}` (i.e. `/run/agenix` by default) won't work here. Agenix don't
        # create sub-directories inside `/run/agenix` and all secrets are placed in it in a flat
        # layout.
        path = "/run/agenix-per-user/${config.configureForUser}/${config.name}";
      };
    };
in
{
  options.age.secrets = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule secretSubmodule);
    example = lib.literalExpression ''
      {
        "example-user-secret.txt" = {
          file = ./example-user-secret.txt.age;
          # The following settings are implied by `configureForUser`:
          # - `owner = "example-user"`
          # - `group = "example-user"`, if set
          # - `path = "/run/agenix/per-user/example-user/user-secret.txt"`
          configureForUser = "example-user";
        };
      };
    '';
  };
}
