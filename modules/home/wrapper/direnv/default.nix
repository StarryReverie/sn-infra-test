{
  config,
  lib,
  pkgs,
  ...
}:
{
  wrappers.direnv.basePackage = pkgs.direnv;

  settings.zsh.initContent = ''
    eval "$(${lib.getExe config.wrapperConfigurations.finalPackages.direnv} hook zsh)"
  '';
}
