{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  custom.users.starryreverie = {
    applications.zsh = {
      shellAliases = {
        ls = "eza";
        la = "eza --all --all";
        ll = "eza --long";
        lla = "eza --long --all --all";
        tree = "eza --tree";
      };
    };
  };

  users.users.starryreverie.maid = {
    packages = [
      (inputs.wrapper-manager.lib.wrapWith pkgs {
        basePackage = pkgs.eza;

        prependFlags = [
          "--icons=never"
          "--no-git"
          "--group-directories-first"
          "--binary"
          "--time-style=long-iso"
        ];

        env = {
          EZA_CONFIG_DIR.value = lib.fileset.toSource {
            root = ./.;
            fileset = ./theme.yml;
          };
        };
      })
    ];
  };
}
