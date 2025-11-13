{
  config,
  lib,
  pkgs,
  ...
}:
let
  configFile = pkgs.writers.writeYAML "config.yaml" {
    gui = {
      language = "en";
      timeFormat = "2006/01/02";
      showRandomTip = false;
      border = "single";
    };

    git = {
      pagers = lib.singleton {
        externalDiffCommand = "${lib.getExe pkgs.difftastic} --color=always";
      };
    };

    update = {
      method = "never";
    };

    disableStartupPopups = true;
  };
in
{
  wrappers.lazygit.basePackage = pkgs.lazygit;

  wrappers.lazygit.prependFlags = [
    "--use-config-file=${configFile}"
  ];

  settings.zsh.shellAliases = {
    lg = "lazygit";
  };
}
