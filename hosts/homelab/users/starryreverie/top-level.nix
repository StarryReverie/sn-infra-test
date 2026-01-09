{
  config,
  lib,
  pkgs,
  flakeRoot,
  ...
}:
let
  userModuleRoot = flakeRoot + /modules/users/starryreverie;
in
{
  imports = [
    # Common user modules
    (userModuleRoot + /atuin)
    (userModuleRoot + /bat)
    (userModuleRoot + /difftastic)
    (userModuleRoot + /direnv)
    (userModuleRoot + /environment)
    (userModuleRoot + /eza)
    (userModuleRoot + /fastfetch)
    (userModuleRoot + /fd)
    (userModuleRoot + /fzf)
    (userModuleRoot + /git)
    (userModuleRoot + /helix)
    (userModuleRoot + /lazygit)
    (userModuleRoot + /password)
    (userModuleRoot + /ripgrep)
    (userModuleRoot + /yazi)
    (userModuleRoot + /zellij)
    (userModuleRoot + /zoxide)
    (userModuleRoot + /zsh)
  ];

  users.users.starryreverie = {
    uid = 1000;
    group = config.users.groups.starryreverie.name;
    isNormalUser = true;
    shell = pkgs.zsh;

    extraGroups = [
      "wheel"
    ]
    ++ lib.optionals config.networking.networkmanager.enable [
      "networkmanager"
    ];

    packages = with pkgs; [
      htop
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQrkIsLMV70klKFtQY8JK5QgXKGyTpZcIaLarXG5dBv"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBHhBWBm0pl855WnAlKB6567DR3fzAWPYAbYI4YxmYFu starryreverie@starrynix-workstation"
    ];
  };

  users.groups.starryreverie = {
    gid = config.users.users.starryreverie.uid;
  };

  programs.zsh.enable = true;
}
