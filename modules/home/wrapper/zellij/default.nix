{
  config,
  lib,
  pkgs,
  ...
}:
let
  configDir = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./config.kdl
      ./layouts
    ];
  };
in
{
  wrappers.zellij.basePackage = pkgs.zellij;

  wrappers.zellij.prependFlags = [
    "--config-dir=${configDir}"
  ];

  settings.zsh.shellAliases = {
    zj = "zellij";
    zd = "zellij --layout development";
  };

  settings.zsh.initContent = ''
    # Zellij helpers
    ## Attach to a session selected using fzf
    function za() {
        zellij delete-all-sessions --yes 2>&1 > /dev/null
        selected=$(zellij list-sessions | awk --field-separator ' ' '{ print $1 }' | sort | fzf --select-1 --height=~10)
        [ -n "$selected" ] && zellij attach "$selected"
    }
  '';
}
