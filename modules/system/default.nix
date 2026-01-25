{
  config,
  lib,
  pkgs,
  ...
}:
let
  mkEntry = domain: feature: {
    ${domain}.${feature}.enable = lib.mkOption {
      type = lib.types.bool;
      description = ''
        Whether to system-scoped feature option `custom.${domain}.${feature}`.
        If at least one `users.users.<user>.custom.${domain}.${feature}.enable`
        exists and is set to `true`, then this option will be enabled as well
        by default.
      '';
      default = lib.pipe config.users.users [
        lib.attrsets.attrValues
        (lib.lists.map (cfg: cfg.custom.${domain}.${feature}.enable or false))
        (lib.lists.any lib.id)
      ];
      defaultText = ''
        `true` if any of `users.users.<name>.custom.${domain}.${feature}.enable`
        is `true`, otherwise `false`
      '';
      example = true;
    };
  };
in
{
  options.custom = lib.attrsets.foldAttrs lib.attrsets.recursiveUpdate { } [
    (mkEntry "applications" "git")
    (mkEntry "applications" "zsh")
    (mkEntry "core" "xdg")
    (mkEntry "hardware" "nvidia-graphics")
    (mkEntry "services" "mpd-ecosystem")
    (mkEntry "services" "transparent-proxy")
  ];
}
