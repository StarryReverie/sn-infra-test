{
  config,
  lib,
  pkgs,
  ...
}:
let
  fdExecutable = lib.getExe pkgs.fd;
in
{
  wrappers.fzf.basePackage = pkgs.fzf;

  wrappers.fzf.env = {
    FZF_DEFAULT_OPTS.value = builtins.concatStringsSep " " [
      "--ansi"
      "--reverse"
      "--scroll-off=5"
      "--cycle"
    ];

    FZF_DEFAULT_COMMAND.value = ''
      ${fdExecutable} --follow --color=always -E ".git" -E "build" -E "target" -E "node_modules" .
    '';
  };
}
