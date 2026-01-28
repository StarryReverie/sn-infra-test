{
  config,
  lib,
  pkgs,
  ...
}:
let
  customCfg = config.custom.system.services.dconf;
in
{
  config = lib.mkIf customCfg.enable {
    programs.dconf.enable = true;

    environment.pathsToLink = [ "/share/gsettings-schemas" ];

    environment.sessionVariables = {
      GSETTINGS_SCHEMA_DIR =
        let
          gsettingsSchemaRoots = lib.pipe config.environment.profiles [
            (lib.lists.map (profile: "\"${profile}/share/gsettings-schemas\""))
            (lib.strings.concatStringsSep " ")
          ];
          searchScript = pkgs.replaceVars ./search-gsettings-schemas.sh {
            inherit gsettingsSchemaRoots;
          };
        in
        "$(bash ${searchScript})";
    };
  };
}
