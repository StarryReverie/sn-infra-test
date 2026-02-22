{
  config,
  lib,
  pkgs,
  ...
}:
let
  customCfg = config.custom.system.core.localization;
in
{
  config = lib.mkIf customCfg.enable {
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocales = lib.pipe config.custom.users [
      lib.attrsets.attrValues
      (lib.lists.filter (cfg: cfg.core.localization.enable))
      (lib.lists.map (cfg: cfg.core.localization.mainLocaleSupport))
    ];
  };
}
