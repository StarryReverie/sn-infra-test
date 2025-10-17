{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.atuin.enable = true;

  programs.atuin.settings = {
    update_check = false;
    style = "compact";
    show_help = false;
    enter_accept = true;
    workspaces = true;
    inline_height = 15;

    common_subcommands = [
      "nix"
      "cargo"
      "git"
      "./gradlew"
      "./mvnw"
    ];

    common_prefix = [
      "sudo"
    ];

    history_filter = [
      ''^\\.*''
      ''^git reset.*''
      ''^rm.*''
      ''^ .*''
    ];
  };
}
