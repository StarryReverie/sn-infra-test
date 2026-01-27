{
  config,
  lib,
  pkgs,
  ...
}:
let
  selfCfg = config.custom.users.starryreverie;
  customCfg = selfCfg.programs.fd;
in
{
  config = lib.mkIf customCfg.enable {
    users.users.starryreverie.maid = {
      packages = with pkgs; [ fd ];

      file.xdg_config."fd/ignore".text = ''
        **/node_modules/**
        **/dist/**
        **/{,_}build/**
        **/target/**
        **/{,.}venv/**
        **/__pycache__/**
        **/vendor/**
        **/.gradle/**
      '';
    };
  };
}
