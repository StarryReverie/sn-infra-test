{
  config,
  lib,
  pkgs,
  ...
}:
let
  configFile = pkgs.writers.writeTOML "config.toml" (
    lib.mergeAttrsList [
      { theme = "onedark"; }
      (import ./editor.nix)
      (import ./keybindings.nix lib)
    ]
  );
in
{
  wrappers.helix.basePackage = pkgs.helix;

  wrappers.helix.prependFlags = [
    "--config"
    "${configFile}"
  ];

  settings.zsh.environment = {
    EDITOR = lib.getExe config.wrapperConfigurations.finalPackages.helix;
  };
}
