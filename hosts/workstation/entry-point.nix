{
  inputs,
  constants,
  flakeRoot,
  ...
}@specialArgs:
inputs.nixpkgs.lib.nixosSystem {
  inherit (constants) system;
  inherit specialArgs;

  extraModules = [
    inputs.colmena.nixosModules.deploymentOptions
  ];

  modules = [
    # External modules
    inputs.agenix-rekey.nixosModules.default
    inputs.agenix.nixosModules.default
    inputs.nix-maid.nixosModules.default

    # Colmena
    {
      deployment.allowLocalDeployment = true;
      deployment.targetHost = null;
      deployment.tags = [ "workstation" ];
    }

    # NixOS modules
    (flakeRoot + /modules/nixos/bluetooth)
    (flakeRoot + /modules/nixos/container)
    (flakeRoot + /modules/nixos/dae)
    (flakeRoot + /modules/nixos/distrobox)
    (flakeRoot + /modules/nixos/fcitx5)
    (flakeRoot + /modules/nixos/firefox)
    (flakeRoot + /modules/nixos/font)
    (flakeRoot + /modules/nixos/networking)
    (flakeRoot + /modules/nixos/nix)
    (flakeRoot + /modules/nixos/pipewire)
    (flakeRoot + /modules/nixos/openssh)
    (flakeRoot + /modules/nixos/secret)
    (flakeRoot + /modules/nixos/waydroid)
    (flakeRoot + /modules/nixos/wireless)
    ./nixos/desktop.nix
    ./nixos/hardware.nix
    ./nixos/networking.nix
    ./nixos/system.nix

    # Home modules
    (
      { config, pkgs, ... }:
      {
        imports = [
          (flakeRoot + /modules/users/starryreverie/alacritty)
          (flakeRoot + /modules/users/starryreverie/atuin)
          (flakeRoot + /modules/users/starryreverie/bat)
          (flakeRoot + /modules/users/starryreverie/clipboard)
          (flakeRoot + /modules/users/starryreverie/difftastic)
          (flakeRoot + /modules/users/starryreverie/direnv)
          (flakeRoot + /modules/users/starryreverie/environment)
          (flakeRoot + /modules/users/starryreverie/eza)
          (flakeRoot + /modules/users/starryreverie/fastfetch)
          (flakeRoot + /modules/users/starryreverie/fd)
          (flakeRoot + /modules/users/starryreverie/fzf)
          (flakeRoot + /modules/users/starryreverie/git)
          (flakeRoot + /modules/users/starryreverie/github-copilot-cli)
          (flakeRoot + /modules/users/starryreverie/gtk-theme)
          (flakeRoot + /modules/users/starryreverie/helix)
          (flakeRoot + /modules/users/starryreverie/hyprlock)
          (flakeRoot + /modules/users/starryreverie/lazygit)
          (flakeRoot + /modules/users/starryreverie/niri-environment)
          (flakeRoot + /modules/users/starryreverie/qt-theme)
          (flakeRoot + /modules/users/starryreverie/ripgrep)
          (flakeRoot + /modules/users/starryreverie/rofi)
          (flakeRoot + /modules/users/starryreverie/swaync)
          (flakeRoot + /modules/users/starryreverie/vscode)
          (flakeRoot + /modules/users/starryreverie/waybar)
          (flakeRoot + /modules/users/starryreverie/wpaperd)
          (flakeRoot + /modules/users/starryreverie/xdg)
          (flakeRoot + /modules/users/starryreverie/yazi)
          (flakeRoot + /modules/users/starryreverie/zellij)
          (flakeRoot + /modules/users/starryreverie/zoxide)
          (flakeRoot + /modules/users/starryreverie/zsh)
          ./users/starryreverie/kanshi.nix
          ./users/starryreverie/niri-environment.nix
        ];
      }
    )
  ];
}
